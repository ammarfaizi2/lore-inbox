Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130750AbRBVDdL>; Wed, 21 Feb 2001 22:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130988AbRBVDcv>; Wed, 21 Feb 2001 22:32:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:7431 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130750AbRBVDcn>; Wed, 21 Feb 2001 22:32:43 -0500
Date: Wed, 21 Feb 2001 19:32:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Heil <kerndev@sc-software.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.2
In-Reply-To: <Pine.LNX.3.95.1010221182554.14140C-100000@scsoftware.sc-software.com>
Message-ID: <Pine.LNX.4.10.10102211931050.1129-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Feb 2001, John Heil wrote:
> 
> Which -ac series patch does this match up with or superceed
> ie should this be considered superior to -ac19 ?

There is no 1:1 comparison to _any_ of the -ac patches, I'm afraid. The
two series are fairly disparate, as they have different intentions. Alan
accepts some stuff that I would be nervous about, and sometimes I say "to
hell with it, we need to fix this" and make Alan nervous.

		Linus

