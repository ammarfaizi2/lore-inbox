Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285723AbRLHBUt>; Fri, 7 Dec 2001 20:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285724AbRLHBUj>; Fri, 7 Dec 2001 20:20:39 -0500
Received: from smtpd.ha-net.ptd.net ([207.44.96.84]:12426 "HELO
	smtpd.ha-net.ptd.net") by vger.kernel.org with SMTP
	id <S285723AbRLHBUe>; Fri, 7 Dec 2001 20:20:34 -0500
Date: Fri, 7 Dec 2001 20:21:52 -0500 (EST)
From: Stan Benoit <sab7@mail.ptd.net>
X-X-Sender: <sab7@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: bugreport 2.4.10
Message-ID: <Pine.LNX.4.33.0112072017400.911-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hope I do this right.

kernel 2.4.10
Processor: AMD850
Memory: 780 meg
Device: logitech Trackman Marble FX

Problem:
PS/2 mouse fails to start

from /var/log/messages

Dec  7 18:19:47 main gpm[712]: oops() invoked from gpm.c(978)
Dec  7 18:19:47 main gpm: gpm startup succeeded
Dec  7 18:19:47 main gpm[712]: /dev/mouse: Device or resource busy


-- 
Stan Benoit<sab7@mail.NoSpAm.ptd.net>
http://home.ptd.net/~sab7

