Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUHJMv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUHJMv1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUHJMuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:50:08 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:28639 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S265029AbUHJMr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:47:29 -0400
Date: Tue, 10 Aug 2004 14:46:29 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101246.i7ACkTbm014030@burner.fokus.fraunhofer.de>
To: mj@ucw.cz, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Martin Mares <mj@ucw.cz>

>I think that it is very reasonable to expect that a program honors the locale
>settings or uses only ASCII characters.

>(In this matter, I share your feelings, because I also have non-ASCII
>characters in my name, but if I decide to print my name in its full
>glory, I respect the locales and don't assume that all the world uses
>iso-8859-2 as I do.)

Your statements are correct for programs that include locale support.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
