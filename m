Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315287AbSGNN7X>; Sun, 14 Jul 2002 09:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSGNN7W>; Sun, 14 Jul 2002 09:59:22 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:37263 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S315287AbSGNN7V>; Sun, 14 Jul 2002 09:59:21 -0400
Date: Sun, 14 Jul 2002 16:00:37 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141400.g6EE0brJ019110@burner.fokus.gmd.de>
To: root@chaos.analogic.com, schilling@fokus.gmd.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From root@chaos.analogic.com Fri Jul 12 22:18:47 2002

>As much as I hate IDE, IDE isn't going away. All my systems use SCSI
>so on machines that have CD/ROMS, I use your libraries and your tools.

>Maybe somebody should make CD/ROM code that directly talks to IDE via
>/dev/hdwhatever, instead of expecting you to modify your code that
>has worked so well for so long.

This would be a really bad idea.

Such a change would force me to add a 6th (and unneeded) new interface.
Why? What problem would be solved if you did introduce such an interface?

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
