Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbSLaSzT>; Tue, 31 Dec 2002 13:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSLaSzT>; Tue, 31 Dec 2002 13:55:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26888 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264688AbSLaSzT>; Tue, 31 Dec 2002 13:55:19 -0500
Date: Tue, 31 Dec 2002 10:58:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tomas Szepe <szepe@pinerecords.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix up UP in 2.5-bkcurrent
In-Reply-To: <20021231083825.GS21097@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0212311058050.2697-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Dec 2002, Tomas Szepe wrote:
> 
> The following bit is needed to build (and boot) current 2.5 bk on
> UP.  The fix just favors a "we may have to do this" comment. <g>

Damn, I even tested that on UP, but I tested it on UP-without-APIC, so I 
didn't see any problems. Thanks,

		Linus

