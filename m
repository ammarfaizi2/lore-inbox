Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSDEVtK>; Fri, 5 Apr 2002 16:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313639AbSDEVsv>; Fri, 5 Apr 2002 16:48:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56591 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313638AbSDEVsk>; Fri, 5 Apr 2002 16:48:40 -0500
Date: Fri, 5 Apr 2002 13:48:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hans Reiser <reiser@namesys.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS Bug Fixes 3 of 6 (Please apply all 6)
In-Reply-To: <200204052027.g35KRc002869@bitshadow.namesys.com>
Message-ID: <Pine.LNX.4.33.0204051347500.1746-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 6 Apr 2002, Hans Reiser wrote:
> 
> This changeset is to fix several reiserfs problems which can be
> fixed in non-intrusive way.

Please don't use bk patches, they have turned out to be pretty much 
unusable.

Either make a (controlled) bk tree available for pulling, or just use 
old-fashioned patches.

		Linus

