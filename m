Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266339AbUHJPQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266339AbUHJPQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266345AbUHJPQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:16:44 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:63896 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266339AbUHJPQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:16:41 -0400
Date: Tue, 10 Aug 2004 17:15:58 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101515.i7AFFwGs014308@burner.fokus.fraunhofer.de>
To: dwmw2@infradead.org, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       eric@lammerts.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: David Woodhouse <dwmw2@infradead.org>

>On Tue, 2004-08-10 at 15:03 +0200, Joerg Schilling wrote:
>> It seems that you like to constantly discredit yourself :-(

>I think people stopped counting the credits a long time ago.

>> What you use if DEFINITELY NOT cdrecord.

>You argue about nomenclature. What I have definitely calls itself
>cdrecord and is definitely based on your code.

As the people who did create the bastardized version of cdrecord
you are using did not make clear where the official defaults file
for cdrecord is located, they did violate the license of cdrecord.

It really does mot make fun to see useless forks for software including
only modifications that do not give you a single advantage over the original.

The license used with cdrecord allows people to make modifications and to 
rediustribute the versions. 

Not a single modification from one of the Linux distribution I did see so far
did introduce any advantage over the original.

I would love to see cooperations (and there is cooperation with people from 
many places), but the big Linux distributors all fail to cooperate :-(

Look into the mkisofs source, I even needed to include a comment in hope to
prevent people from SuSE to convert legal and correct C code into a broken
piece of code just because  they modify things they don't understand :-(

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
