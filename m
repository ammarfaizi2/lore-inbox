Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUHJK1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUHJK1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUHJK1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:27:21 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:5043 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S264346AbUHJKU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:20:58 -0400
Date: Tue, 10 Aug 2004 12:19:25 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101019.i7AAJPH9012045@burner.fokus.fraunhofer.de>
To: alan@lxorguk.ukuu.org.uk, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org,
       mj@ucw.cz
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From alan@lxorguk.ukuu.org.uk  Mon Aug  9 17:35:14 2004

>export LC_ALL=cy_GB.UTF-8
>run cdrecord 
>review the output. Its using a hardcoded 8859-1/15 symbols so it breaks.

This is a problem of the people who use UTF-8..... sorry, but when
they are tought that moving to UTF-8 is without problems is is just wrong.
N.B. This is not a bug in cdrecord but wrong expectations from the users.

>> BTW: this also appears to your comments on the Solaris device handling....
>> Did you ever install Solaris 10 and test?

>I've seen it on older Solaris. When drives walk between scsi busses as
>the system is running it doesn't like it

If you like that people believe this, you would need to proof it. I've never 
seen it.....so I won't believe until you at least exactly describe the scenario
when this should ocur.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
