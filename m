Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSKJTMD>; Sun, 10 Nov 2002 14:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSKJTMC>; Sun, 10 Nov 2002 14:12:02 -0500
Received: from host194.steeleye.com ([66.206.164.34]:16397 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265097AbSKJTMB>; Sun, 10 Nov 2002 14:12:01 -0500
Message-Id: <200211101918.gAAJIh712647@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Linus Torvalds <torvalds@transmeta.com>
cc: "J.E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BOGUS: megaraid changes 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Sun, 10 Nov 2002 11:11:25 PST." <Pine.LNX.4.44.0211101107400.9581-100000@home.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Nov 2002 14:18:43 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com said:
> That certainly works for me - informational but not irritating. I just
> suspect it will scroll past without being seen that much, though. 

Hopefully we have a winner...

> But along with a stack_dump() or something to make it a bit more
> noticeable it might actually be visible. 

OK, I'll do it this way and put it into the next SCSI merge.

James


