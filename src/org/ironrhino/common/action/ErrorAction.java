package org.ironrhino.common.action;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.ironrhino.core.metadata.AutoConfig;
import org.ironrhino.core.servlet.HttpErrorHandler;
import org.ironrhino.core.struts.BaseAction;
import org.ironrhino.core.util.AuthzUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AccountStatusException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.core.userdetails.UserDetails;

@AutoConfig(namespace = "/")
public class ErrorAction extends BaseAction {

	private static final long serialVersionUID = 7684824080798968019L;

	private static Logger logger = LoggerFactory.getLogger(ErrorAction.class);

	private Exception exception;

	@Autowired(required = false)
	private HttpErrorHandler httpErrorHandler;

	public Exception getException() {
		return exception;
	}

	public String handle() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		int errorcode = 404;
		exception = (Exception) request
				.getAttribute(RequestDispatcher.ERROR_EXCEPTION);
		if (exception instanceof AccountStatusException) {
			if (exception instanceof CredentialsExpiredException) {
				UserDetails ud = AuthzUtils.getUserDetails();
				if (ud != null) {
					targetUrl = "/"
							+ StringUtils.uncapitalize(ud.getClass()
									.getSimpleName()) + "/password";
					return REDIRECT;
				}
			}
			addActionError(getText(exception.getClass().getName()));
			return "accountStatus";
		} else if (exception != null)
			logger.error(exception.getMessage(), exception);
		try {
			errorcode = Integer.valueOf(getUid());
		} catch (Exception e) {

		}
		if (httpErrorHandler != null
				&& httpErrorHandler.handle(request, response, errorcode,
						exception != null ? exception.getMessage() : null))
			return NONE;
		String result;
		switch (errorcode) {
		case HttpServletResponse.SC_UNAUTHORIZED:
			result = ACCESSDENIED;
			break;
		case HttpServletResponse.SC_FORBIDDEN:
			result = ERROR;
			break;
		case HttpServletResponse.SC_NOT_FOUND:
			result = NOTFOUND;
			break;
		case 500:
			result = "internalServerError";
			break;
		default:
			result = NOTFOUND;
		}
		response.setStatus(errorcode);
		return result;
	}
}
