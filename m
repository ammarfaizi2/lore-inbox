Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130519AbRCFMFV>; Tue, 6 Mar 2001 07:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130520AbRCFMFM>; Tue, 6 Mar 2001 07:05:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51720 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130519AbRCFMFF>; Tue, 6 Mar 2001 07:05:05 -0500
Subject: Re: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What happened ? (No
To: greearb@candelatech.com (Ben Greear)
Date: Tue, 6 Mar 2001 12:07:25 +0000 (GMT)
Cc: 0@pervalidus.net (Frédéric L. W. Meunier),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3AA4888F.77E3B422@candelatech.com> from "Ben Greear" at Mar 05, 2001 11:49:51 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14aGFU-0000YQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> running a bad hdparm command while running a full GNOME desktop:
> (This was not a good idea...and I know, and knew that...but....)
> 
> hdparm -X34 -d1 -u1 /dev/hda
> (As found here: http://www.oreillynet.com/pub/a/linux/2000/06/29/hdparm.html?page=2
> 
> Sorry for the lame bug report, but I'm scared to try it again, and
> I didn't realize the complexity of the problem when I simply powered
> down my machine with the HD light on solid...

Its not a bug. As the system administrator you reconfigured a hard disk on
the fly and shit happened. The hdparm man page warnings do exist for a reason.

