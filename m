Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268060AbRG0Tuj>; Fri, 27 Jul 2001 15:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268939AbRG0Tu3>; Fri, 27 Jul 2001 15:50:29 -0400
Received: from web14510.mail.yahoo.com ([216.136.224.169]:28935 "HELO
	web14510.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268931AbRG0TuY>; Fri, 27 Jul 2001 15:50:24 -0400
Message-ID: <20010727195031.57134.qmail@web14510.mail.yahoo.com>
Date: Fri, 27 Jul 2001 12:50:31 -0700 (PDT)
From: Kent Hunt <kenthunt@yahoo.com>
Subject: Longstanding sudden reboots with 2.4 smp kernels
To: lk <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

	I have a problem that continues to persist since the
2.4 test kernels until the latest 2.4.7.
The machine suddently reboots once in a while when I
click some action button in the gnomeicu program. I am
ruling out hardware problems since the box is rock
solid except in the above mentioned situation. It is
frustrating since no messages are left in the kernel
logs when these reboots happen. 
	The box is an ASUS P2BD main board.
	Video card Matrox G400.

	I have run X from 3.3.6 to 4.0.3 and all have this
problem. Can anyone tell me if a userland software
like gnomeicu can trigger a reboot in the kernel? I
think it has to do either with the code the X handles
pointer events or some networking problems since it is
an instant messenger software. But it is intriging
that this only happens with gnomeicu. Anyone with good
suggestions to solve this problem?

	Kent

Please CC and I would be happy to provide any further details.

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
