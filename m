Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267486AbUHJPdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267486AbUHJPdC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267483AbUHJPdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:33:01 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:53922 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267480AbUHJPca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:32:30 -0400
Date: Tue, 10 Aug 2004 17:28:04 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101528.i7AFS4Dh014332@burner.fokus.fraunhofer.de>
To: dwmw2@infradead.org, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       eric@lammerts.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: David Woodhouse <dwmw2@infradead.org>
>> Look into the mkisofs source, I even needed to include a comment in hope to
>> prevent people from SuSE to convert legal and correct C code into a broken
>> piece of code just because  they modify things they don't understand :-(

>Funny that; they _all_ fail to co-operate, even though they all manage
>to co-operate with most other upstream authors. It's probably best that

Looks like you never asked other Authors :-(

I received complaints about similat problem to the one I have from the author
of xcdroast.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
