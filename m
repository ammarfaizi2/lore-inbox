Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135532AbRECC3l>; Wed, 2 May 2001 22:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135694AbRECC3c>; Wed, 2 May 2001 22:29:32 -0400
Received: from 513.holly-springs.nc.us ([216.27.31.173]:63059 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S135532AbRECC3V>; Wed, 2 May 2001 22:29:21 -0400
Subject: Linux syscall speed -- was X15 rootin-tootin webserver
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20010503091459.028524e8@171.69.43.101>
In-Reply-To: <3AEC8562.887CFA72@chromium.com> 
	<4.3.2.7.2.20010503091459.028524e8@171.69.43.101>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 02 May 2001 22:29:20 -0400
Message-Id: <988856961.6355.1.camel@gromit>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to tests performed at IBM:

http://www-106.ibm.com/developerworks/linux/library/l-rt1/

Linux's sycalls are a little more than twice as fast as those of Windows
2000. 0.75usec vs 2.0msec. Not too shabby. And this "magic page" idea
means it may get faster.

-M

