Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUHJKfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUHJKfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUHJKeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:34:22 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:31699 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S264298AbUHJKeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:34:06 -0400
Date: Tue, 10 Aug 2004 12:33:16 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101033.i7AAXGpQ012090@burner.fokus.fraunhofer.de>
To: diablod3@gmail.com, schilling@fokus.fraunhofer.de
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, dwmw2@infradead.org,
       eric@lammerts.org, james.bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Patrick McFarland <diablod3@gmail.com>

>On Mon, 9 Aug 2004 16:40:52 +0200 (CEST), Joerg Schilling
><schilling@fokus.fraunhofer.de> wrote:
>> People who use the official cdrecord know that they need to run cdrecord
>> with root privilleges. People who run the bastardized version from SuSE
>> don't know this and fail to write CDs.

>This is why people should be using Debian to begin with. Debian asks
>if you want to install cdrecord with suid so everyone can burn cds
>without needing to be root first.

Indeed! Altough minor things could be better with Debian too, Debian is the only
true Open Source Linux distribution. Other distributions modify programs 
without reason and do not cooperate with the original authors :-(

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
