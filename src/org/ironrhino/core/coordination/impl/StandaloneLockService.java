package org.ironrhino.core.coordination.impl;

import static org.ironrhino.core.metadata.Profiles.DEFAULT;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.ironrhino.core.coordination.LockService;
import org.ironrhino.core.spring.configuration.ResourcePresentConditional;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

@Component("lockService")
@Profile(DEFAULT)
@ResourcePresentConditional(value = "resources/spring/applicationContext-coordination.xml", negated = true)
public class StandaloneLockService implements LockService {

	private ConcurrentHashMap<String, Lock> locks = new ConcurrentHashMap<String, Lock>();

	@Override
	public boolean tryLock(String name) {
		return getLock(name).tryLock();
	}

	@Override
	public boolean tryLock(String name, long timeout, TimeUnit unit) {
		Lock lock = getLock(name);
		try {
			return lock.tryLock(timeout, unit);
		} catch (InterruptedException e) {
			return false;
		}
	}

	@Override
	public void lock(String name) {
		getLock(name).lock();
	}

	@Override
	public void unlock(String name) {
		getLock(name).unlock();
	}

	private Lock getLock(String name) {
		Lock lock = locks.get(name);
		if (lock == null) {
			Lock newLock = new ReentrantLock();
			lock = locks.putIfAbsent(name, newLock);
			if (lock == null)
				lock = newLock;
		}
		return lock;
	}
}
