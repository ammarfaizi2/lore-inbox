Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314660AbSDTRRy>; Sat, 20 Apr 2002 13:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312972AbSDTRRa>; Sat, 20 Apr 2002 13:17:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54288 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314660AbSDTRRQ>; Sat, 20 Apr 2002 13:17:16 -0400
Date: Sat, 20 Apr 2002 10:16:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: David Lang <dlang@diginsite.com>, Jeff Garzik <garzik@havoc.gtf.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <3CC19FD9.1D3F8168@linux-m68k.org>
Message-ID: <Pine.LNX.4.33.0204201010220.11450-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 20 Apr 2002, Roman Zippel wrote:
> 
> They are lots of kernel projects, which use cvs, but noone before
> considered submitting extensive cvs documentation into the kernel.

More importantly, there was no way in hell I would synchronize with a CVS 
tree, so CVS was a non-entity as far as patch submittal was concerned.

The BK documentation is _nothing_ more than a alternative to
"SubmittingPatches".

Anyway, I'm not going to discuss this any more. If somebody has actual 
construcive ideas about trying to improve other tools or putting the BK 
docs in some place that is equally obvious and easily available for all 
parties but somehow "less disturbing" to people with a weak stomach, go 
for it. But I'm not interested in yet another religious whine-war.

		Linus

