Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287882AbSAYWcR>; Fri, 25 Jan 2002 17:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288051AbSAYWcH>; Fri, 25 Jan 2002 17:32:07 -0500
Received: from sense-jaxley-158.oz.net ([216.39.151.158]:43782 "EHLO
	funhouse.axley.net") by vger.kernel.org with ESMTP
	id <S287882AbSAYWbt>; Fri, 25 Jan 2002 17:31:49 -0500
Message-ID: <1011997901.3c51dccd0d8db@webmail2.axley.net>
Date: Fri, 25 Jan 2002 14:31:41 -0800
From: c o r e <core@axley.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 bug: mysterious hang
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 192.168.1.71
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent a couple of e-mails in December 2001 about this issue (latest on
12-22-2001) and haven't seen any follow-ups that could either a) help me debug
the problem or b) fix the problem.    I have tried booting without any modules
loaded (save for the 2 ext3fs modules) and the problem still occurs and is just
as predictable (run GIMP, load image, create new window, copy and paste image in
new window, move the floating image with mouse and bang--system will freeze). 
This happens at other random times as well (making it very annoying).

I have 2.4.17 compiled from scratch so this is not a RedHat problem.

The system does not respond to anything when it freezes and must be rebooted
with the reset switch.

Thanks for any assistance on this problem.

-core


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
