Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUHJNHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUHJNHR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUHJNGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:06:43 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:62445 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S265127AbUHJNGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:06:23 -0400
Date: Tue, 10 Aug 2004 15:05:37 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101305.i7AD5biZ014084@burner.fokus.fraunhofer.de>
To: mj@ucw.cz, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Martin Mares <mj@ucw.cz>

>> Your statements are correct for programs that include locale support.

>Would you accept a patch to cdrecord to add such support?

Locale support is on a top positoon of my TODO list, adding it for e.g. Solaris
would be extremely simple but my software runs on many platforms.

If you send a patch that includes autoconf support and everything that is needed
else, I would be glad......


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
