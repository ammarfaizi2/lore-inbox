Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbTABTvZ>; Thu, 2 Jan 2003 14:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266433AbTABTvZ>; Thu, 2 Jan 2003 14:51:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58386 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266431AbTABTvY>; Thu, 2 Jan 2003 14:51:24 -0500
Date: Thu, 2 Jan 2003 11:54:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tomas Szepe <szepe@pinerecords.com>
cc: jgarzik@pobox.com, <zaitcev@redhat.com>, <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>, <sparclinux@vger.kernel.org>,
       <linux-m68k@lists.linux-m68k.org>, <netfilter-devel@lists.samba.org>,
       <phillim2@comcast.net>, <rmk@arm.linux.org.uk>
Subject: Re: [PATCHSET] Multiarch kconfig cleanup
In-Reply-To: <20030102182038.GZ17053@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0301021152350.3665-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Jan 2003, Tomas Szepe wrote:
> 
> This is the first time I'm trying to get more than 3 people to work
> together so I'd be grateful if you didn't kick me too hard should I have
> screwed up.

I'd really like to see the organizational patches first (ie the 
net/Kconfig type of changes), and leave the "conditional menu" patches for 
later, especially as they would seem to be improved by an extension to the 
config language (ie the "menucond" thing).

Also, I don't fetch patches, I'd much rather just be mailbombed.

		Linus

