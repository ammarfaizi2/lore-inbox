Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284138AbRLRQEz>; Tue, 18 Dec 2001 11:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284139AbRLRQEq>; Tue, 18 Dec 2001 11:04:46 -0500
Received: from m788-mp1-cvx1b.edi.ntl.com ([62.253.11.20]:19438 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284138AbRLRQEf>; Tue, 18 Dec 2001 11:04:35 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181459.fBIExrW15830@pinkpanther.swansea.linux.org.uk>
Subject: Re: Limits broken in 2.4.x kernel.
To: war@starband.net (war)
Date: Tue, 18 Dec 2001 14:59:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <3C1E5A88.57F5A68A@starband.net> from "war" at Dec 17, 2001 03:50:16 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> would be limited to 3 processes.
> 
> I was curious if this fix would ever be merged into the Linux Kernel so
> limits would actually work properly?

Linus kept rejecting it. Now we have Marcelo as 2.4.x maintainer I'll
look at submitting it. 2.5 will no doubt stay broken for a while.

