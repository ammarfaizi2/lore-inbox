Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTJXKvX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 06:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTJXKvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 06:51:23 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:30444 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261890AbTJXKvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 06:51:21 -0400
Date: Fri, 24 Oct 2003 12:51:19 +0200 (MEST)
From: News Admin <news@nimloth.ics.muni.cz>
Message-Id: <200310241051.h9OApJsC025438@nimloth.ics.muni.cz>
To: linux-kernel@vger.kernel.org
X-Muni-Spam-TestIP: 147.251.6.10
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From news Fri Oct 24 12:51:19 2003
Received: (from news@localhost)
	by nimloth.ics.muni.cz (8.12.8/8.10.0.Beta12) id h9OApIVD025424
	for newsmaster; Fri, 24 Oct 2003 12:51:18 +0200 (MEST)
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: Re: Linux 2.4.23-pre8
Message-ID: <3F990425.236C2AE2@i.am>
Sender: UNKNOWN@decibel.fi.muni.cz
Date: Fri, 24 Oct 2003 10:51:17 GMT
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-Nntp-Posting-Host: decibel.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
Mime-Version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.23-pre7-pac2 i686)
Organization: unknown

Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes -pre8... It contains a quite big amount of ACPI fixes,
> networking changes, network driver changes, few IDE fixes, SPARC merge, SH
> merge, tmpfs fixes, NFS fixes, important VM typo fix, amongst others.
> 
> People seeing boot IDE related crashes on Alpha with previous kernels
> please try this.
> 
> Have fun

Hi

I'd like to have some fun - but first I'd need to have the patches
from -pac2 for e1000 moved into the kernel.

FYI  e1000 doesn't work with any 2.4.22 kernel - which gets really
funny considering it's the most used on-board gigabit card...


-- 
  .''`.
 : :' :    Zdenek Kabelac  kabi@{debian.org, users.sf.net, fi.muni.cz}
 `. `'           Debian GNU/Linux maintainer - www.debian.{org,cz}
   `-

