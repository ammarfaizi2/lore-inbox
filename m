Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266275AbUHJOBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUHJOBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 10:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUHJMma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:42:30 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:25564 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S264954AbUHJMmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:42:01 -0400
Date: Tue, 10 Aug 2004 14:41:05 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101241.i7ACf5WC013958@burner.fokus.fraunhofer.de>
To: matthias.andree@gmx.de, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       eric@lammerts.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Matthias Andree <matthias.andree@gmx.de>

>> >From: Jens Axboe <axboe@suse.de>
>> 
>> >> Please try again after you had a look into the cdrtools sources.
>> >> 
>> >> Cdrecord also needs privilleges to lock memory and to raise prioirity.
>> 
>> >They are not required, or at least not with the version I use. It warns
>> >of failing to set priority and lock memory, I can continue fine though.
>> >With the casual burning of CDs I do, it's never been a problem.
>> 
>> You should believe people who know better.....

>Jï¿½rg, this is insulting. Who knows better than Jens if his computer has
>needed burn-proof and if his writes have been successful?  You for one
>don't. I don't either but at least I don't claim to.

So you really like to recommend everyone to cross the street while the 
traffic light shows red just because you did not yet get any harm from doing 
so? 

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
