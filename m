Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266568AbUHINq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266568AbUHINq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUHINq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:46:57 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:39592 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266568AbUHINqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:46:55 -0400
Date: Mon, 9 Aug 2004 15:46:13 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091346.i79DkDRi010405@burner.fokus.fraunhofer.de>
To: schilling@fokus.fraunhofer.de, skraw@ithnet.com
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Stephan von Krawczynski <skraw@ithnet.com>

>Understand this: _nobody_ expects you to know everything about 25 different
>OS's, the only thing that can be expected is that you simply listen to the
>different parties knowing the different platforms and _take their advice_,
>really not more.

While this works for most if not all OS, it does not work for Linux.

For Linux, the percentage of things that are reported incorrect to me is higher
than 80%, so I need to use my own extertise. If I would not, cdrecord would be
unusable.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
