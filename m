Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUHIOrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUHIOrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266766AbUHIOo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:44:57 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:29394 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266611AbUHIOoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:44:14 -0400
Date: Mon, 9 Aug 2004 16:43:34 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091443.i79EhYKP010656@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, eric@lammerts.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Jens Axboe <axboe@suse.de>

>> Please try again after you had a look into the cdrtools sources.
>> 
>> Cdrecord also needs privilleges to lock memory and to raise prioirity.

>They are not required, or at least not with the version I use. It warns
>of failing to set priority and lock memory, I can continue fine though.
>With the casual burning of CDs I do, it's never been a problem.

You should believe people who know better.....


If cdrecord runs as it is intended to run, it is not affected by Netscape
paging and similar....

Running a test first means to know what to test.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
