package org.ironrhino.core.metadata;

import org.ironrhino.core.model.Displayable;
import org.ironrhino.core.struts.I18N;

public enum Scope implements Displayable {
	LOCAL, // only this jvm
	APPLICATION, // all jvm for this application
	GLOBAL; // all jvm for all application

	@Override
	public String getName() {
		return name();
	}

	@Override
	public String getDisplayName() {
		try {
			return I18N.getText(getClass(), name());
		} catch (Exception e) {
			return name();
		}
	}

	public static Scope parse(String name) {
		if (name != null)
			for (Scope en : values())
				if (name.equals(en.name()) || name.equals(en.getDisplayName()))
					return en;
		return null;
	}

	@Override
	public String toString() {
		return getDisplayName();
	}
}
