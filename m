Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316605AbSGNNXk>; Sun, 14 Jul 2002 09:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316606AbSGNNXj>; Sun, 14 Jul 2002 09:23:39 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:1408 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316605AbSGNNXj>; Sun, 14 Jul 2002 09:23:39 -0400
Date: Sun, 14 Jul 2002 15:24:57 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141324.g6EDOvUe019079@burner.fokus.gmd.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Thunder wrote:

>Because we can't tell Linux users "your (once favorite) CD-ROM is not 
>implemented in Linux (any more), and will never ever be". If we explicitly 
>exclude hardware, where do we end?!

It would help if you educate yourself before you wrtite to the thread.
This could help a lot to keep this discussion technical.

If a CD-ROM does not support ATAPI, you are not able to

-	open/close/lock the door.

-	Rip Audio from it.

People who really cannot affort to buy a new drive will still be able
to see the drive as read-only HD.

In addition, if the drive would support DAE via some non-standard interface
nobody would be happy with it. The DAE 	quality would be lousy and none of 
the programs that is still supported would be able to use the drive
decently for DAE.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
