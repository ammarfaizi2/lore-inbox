Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267391AbUHXEO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUHXEO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 00:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268180AbUHXEO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 00:14:56 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:44482 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267391AbUHXEOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 00:14:51 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 24 Aug 2004 06:14:06 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
Message-ID: <412AC08E.nailBG411JOFC@burner>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Halder wrote:

>True, to europeans this sounds far too overenthusiastic - almost like a 
>commercial - and will most certainly lead to the impression, that the 
>article is not very serious.
>
>Europeans try to write serious articles VERY neutral - any personal 
>opinion(s) will only be a short statement at the very end of the article.

No, it is definitely not overestimated.

It is more likely to rather be the opposite and you will find this out if you
try to use dtrace or attend a demo.

Dou you know of any other system where you can say:

	Print me a strack trace with symbols for all processes on this
	computer (even stripped ones) that call gettimeofday() within the
	next few seconds.

Note that you do not need a special kernel, no reboot, no restart of 
applications.

There are a lot more possibilities including tracing kernel routines on a 
production kernel but it would take too long to describe them....

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
