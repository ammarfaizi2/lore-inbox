Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUHJM5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUHJM5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264973AbUHJMzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:55:08 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:62179 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S265029AbUHJMyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:54:50 -0400
Date: Tue, 10 Aug 2004 14:47:56 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101247.i7AClub5014046@burner.fokus.fraunhofer.de>
To: dwmw2@infradead.org, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       eric@lammerts.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: David Woodhouse <dwmw2@infradead.org>

>> Burn-Proof is switched off by default and other protections (invented later)
>> are switched off by cdrecord to get compatibility..... if you only had read the 
>> man page......
>> 
>> Switching Burn-Proof on will reduce the quality of the CDs.

>I haven't even stated which distribution I'm running. How can you
>possibly know what it puts into /etc/cdrecord.conf when it detects my
>CD-R? What relation has this to your man page?

Cdrecord does not read /etc/cdrecord.conf

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
./
