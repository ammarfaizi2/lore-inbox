Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266737AbUHIO7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266737AbUHIO7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUHIO7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:59:05 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:52702 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266680AbUHIO6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:58:25 -0400
Date: Mon, 9 Aug 2004 16:57:37 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091457.i79EvbrX010682@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Jens Axboe <axboe@suse.de>

>> DMA abstraction does not fix HW bugs, it only allows you to behave the
>> same for all "DMA users" for the same HW in the kernel.

>If they all use the interface. Like with all interfaces, it takes time
>before it's being used kernel-wide.

I did mention DMA abstraction in LKML in 1999 or even earlier.....
It is a long time since then.


>I have lots of discussions on linux-kernel, and not all of them (very
>few, in fact) end up in flames. You seem to end up in flames with
>basically everyone. At least on linux-kernel, I believe my track record
>is far better than yours. Your mails are often infuriating.

You need to distinct between boot licking people and people who know what
they are talking about. It seems that you are missing the needed discussion
stile in order to be able to discuss things with people that are not of your
opinion. I _am_ able to do this and it was alway you to come up with personal
insultings, altough I know that even pure technical discussions may be very 
"hot"...

Note that you did always block when I asked you for giving technical arguments.

At last: I am always open to people wo have the needed discussion style and the
technical background to talk about things, but I don't like the kind of 
discussions I am always thrown into on LKML because they start with bashing me.

Once you learned how to discuss things on a result oriented way, I would be 
happy to see mail from you again.

Meanwhile, have a nice day.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
