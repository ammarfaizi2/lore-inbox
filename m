Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUHJO2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUHJO2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 10:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUHJO2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 10:28:10 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:9459 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S265108AbUHJO2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 10:28:06 -0400
Date: Tue, 10 Aug 2004 16:27:13 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408101427.i7AERDld014134@burner.fokus.fraunhofer.de>
To: schilling@fokus.fraunhofer.de, skraw@ithnet.com
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, diablod3@gmail.com,
       dwmw2@infradead.org, eric@lammerts.org, james.bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Stephan von Krawczynski <skraw@ithnet.com>
>> Indeed! Altough minor things could be better with Debian too, Debian is the
>> only true Open Source Linux distribution. Other distributions modify programs
>> without reason and do not cooperate with the original authors :-(

>Would you mind to stop your general accusations against "other distributions"
>and your talking for people (i.e. authors) that you don't know or haven't
>talked to in your whole lifetime.

>Fortunately everybody can decide for himself what distro he likes best. And if
>someone thinks he has to modify the original GPL source, then he should do.
>If you don't like that, don't use GPL, because the right to modify foreign
>sources is a major part of it.

You seem to forget that the main problems are:

-	These distributions do not talk with the original Authors which
	demonstrates that they do not like to benefit from OSS.

-	The modified versions of cdrtools found in distributions are _all_
	worse than the original. As some of the distributions (e.g. SuSE)
	even published versions known to be defective, they violate 
	the GPL (subsection 6 of the preamble).


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
