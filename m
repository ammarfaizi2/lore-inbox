Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285899AbRLHK6W>; Sat, 8 Dec 2001 05:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285901AbRLHK6M>; Sat, 8 Dec 2001 05:58:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31749 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285899AbRLHK6C>; Sat, 8 Dec 2001 05:58:02 -0500
Subject: Re: Would the father of init_mem_lth please stand up
To: zaitcev@redhat.com (Pete Zaitcev)
Date: Sat, 8 Dec 2001 11:07:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
In-Reply-To: <20011207234048.A31442@devserv.devel.redhat.com> from "Pete Zaitcev" at Dec 07, 2001 11:40:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CfK5-000135-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Really someone needs slapping across. What kind of code is that
> (in 2.5.1-pre6):

Whoever merged that crap also wants a good kicking. First we have the joke
ps/2 merge, now this. Is Linus trying to force someone to take over or is
small children combined with a pending christmas really the doom that some
folks claim 8)

> I stringly urge Linus to drop this so-called "cleanup" from 2.5.1.
> 
> No doubt, the existing code was bad. I fixed it somewhat for 2.4,
> and am feeding it to Marcelo. I can forward-port that to 2.5
> if anyone is interested.

Did you clean it up as far as making the disks an array of pointers not
of objects ?

Alan
