Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266752AbUHIOuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266752AbUHIOuq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266777AbUHIOnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:43:19 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:51151 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266740AbUHIOlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:41:31 -0400
Date: Mon, 9 Aug 2004 16:40:52 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091440.i79EeqrH010640@burner.fokus.fraunhofer.de>
To: dwmw2@infradead.org, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       eric@lammerts.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: David Woodhouse <dwmw2@infradead.org>

>On Mon, 2004-08-09 at 16:12 +0200, Joerg Schilling wrote:
>> If you are right, why then is SuSE removing the warnings in cdrecord
>> that are there to tell the user that cdrecord is running with insufficient 
>> privilleges?

>Because those warnings are bogus, put there by someone who likes to
>complain about things that are not _really_ a problem?

Try to inform yourself before sending wrong mails.....

People who use the official cdrecord know that they need to run cdrecord
with root privilleges. People who run the bastardized version from SuSE
don't know this and fail to write CDs.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
