Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUHJVd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUHJVd4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267727AbUHJVd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:33:56 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:49560 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267595AbUHJVdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:33:54 -0400
Date: Tue, 10 Aug 2004 23:33:10 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408102133.i7ALXAOf014580@burner.fokus.fraunhofer.de>
To: jbglaw@lug-owl.de, skraw@ithnet.com
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, diablod3@gmail.com,
       dwmw2@infradead.org, eric@lammerts.org, james.bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Stephan von Krawczynski <skraw@ithnet.com>

>On Tue, 10 Aug 2004 18:10:57 +0200
>Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:

>> Actually, I use Debian since, um, long ago:)  But accept that Jörg
>> doesn't really like to care about f*cked up patched versions of
>> cdrecord.

>He does not need to. Nobody told him to do.
>Besides I doubt that only the patched versions are actually "f*cked up".
>My personal experience with cdrecord is that neither version works well on my
>system.

As you did not mention which writer and wich OS you are talking, it is hard to 
tell anything about the reasons.

If you like to write DVDs, you of course need cdrecord-ProDVD

ftp://ftp.berlios.de/pub/cdrecord/ProDVD/

I am trying my best so support any DVD writer since 1997

Note that there is no DVD support in the GPLd cdrecord and if you use the 
original version, you will get hints leading you to cdrecord-ProDVD.

Also note that I don't like to feed trolls, so I don't like to discuss
cdrecord-ProDVD here and I will not answer related questions - they are all
answered in the documentation. Cdrecord-ProDVD is free for personal use and 
this will not change in the future.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
