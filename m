Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSGNMa7>; Sun, 14 Jul 2002 08:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316199AbSGNMa6>; Sun, 14 Jul 2002 08:30:58 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:1010 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316182AbSGNMa6>; Sun, 14 Jul 2002 08:30:58 -0400
Date: Sun, 14 Jul 2002 14:32:15 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207141232.g6ECWF5n019043@burner.fokus.gmd.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Eric Anderson wrote:

>cdrecord should use the CDROM_SEND_PACKET ioctl, then it would
>work regardless,

This only prooves that you are uninformed :-(

In addition, the exiestence of thiid ioctl is just another proof
that there is no overall planning in Linux. Everyone adds new 
interfaces without any concept. If Linux likes to convert from 
a hobbyist kernel to a professional OS, there is need for overall
planning by people who know about OS concepts.

For now, I only see people who may know a lot about Linux but lack
general OS knowledge. Knowlede does not result from looking at your belly
but from looking at other people's ideas...


Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
