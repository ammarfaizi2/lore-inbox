Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267300AbSKSVpA>; Tue, 19 Nov 2002 16:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267344AbSKSVpA>; Tue, 19 Nov 2002 16:45:00 -0500
Received: from [207.22.154.234] ([207.22.154.234]:57028 "HELO oa2.largo.com")
	by vger.kernel.org with SMTP id <S267300AbSKSVo6>;
	Tue, 19 Nov 2002 16:44:58 -0500
Subject: Off List Message - Kernel Problem - Respond To Me
From: Dave Richards <drichard@largo.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1037742240.31569.9.camel@oa3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 19 Nov 2002 16:44:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello-
        The City of Largo is a big KDE/Linux shop, as many of you are
aware we run
about 800 unique users, on 450 thin clients running the KDE desktop.

        We upgraded from RedHat 7.2 to RedHat 7.3 and therefore from KDE
2.x to
KDE 3.x.  There seems to be a scaling problem that was introduced in KDE
3.x that we cannot resolve.  Previously a Dual 933Mhz system would
easily run 200+ users at once, but now the KDE 3.x runs out of resources
around 91 users.  We have been told that it's related to the maximum
number of threads allowed in the 2.4 kernel itself and is not something
that can be fixed.  When we get to the 91st person, we started getting
this message-->

Nov 19 14:09:41 desktop_a kernel: ldt allocation failed

We get this error over and over again and no additional users can log
into the server.


I'm not on the linux-kernel list, but if anyone has insight into this
issue, please drop me a line.  If you know a way to fix this in the 2.4
kernel too, or can verify that we have to wait for 2.5/2.6 we need to
know that too.

Thanks as always for your help
Dave Richards
City of Largo, FL
Systems Administrator.
-- 
Dave Richards <drichard@largo.com>

