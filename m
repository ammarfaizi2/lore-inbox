Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUHIMAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUHIMAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266500AbUHIMAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:00:23 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:30914 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266498AbUHIL73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 07:59:29 -0400
Date: Mon, 9 Aug 2004 13:58:43 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091158.i79BwhPj009609@burner.fokus.fraunhofer.de>
To: alan@lxorguk.ukuu.org.uk, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org,
       mj@ucw.cz
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Alan Cox <alan@lxorguk.ukuu.org.uk>

>BTW while I remember cdrecord has a bug with hardcoded iso8859-1
>copyright symbols in it which mean your copyright banner is invalid
>unicode on a UTF-8 locale.


It seems that you like to write unproven and thus wrong things :-(

BTW: this also appears to your comments on the Solaris device handling....
Did you ever install Solaris 10 and test?

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
