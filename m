Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUHJMs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUHJMs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbUHJMqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:46:50 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:25054 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S264937AbUHJMpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:45:50 -0400
Date: Tue, 10 Aug 2004 14:45:06 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101245.i7ACj6EM014024@burner.fokus.fraunhofer.de>
To: mj@ucw.cz, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       dwmw2@infradead.org, eric@lammerts.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Martin Mares <mj@ucw.cz>

>> Switching Burn-Proof on will reduce the quality of the CDs.

>BTW is it true that Burn-Proof reduces the quality exactly in the cases
>where burning without Burn-Proof would ruin the disk?

This is why it is silly to tell people that they do not need locked memory and
raised scheduling priority for CD/DVD writing.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
