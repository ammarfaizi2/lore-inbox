Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbREVQCo>; Tue, 22 May 2001 12:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261990AbREVQCe>; Tue, 22 May 2001 12:02:34 -0400
Received: from irmgard.exp-math.uni-essen.de ([132.252.150.18]:24839 "EHLO
	irmgard.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id <S261999AbREVQCP>; Tue, 22 May 2001 12:02:15 -0400
Date: Tue, 22 May 2001 18:02:12 +0200 (MESZ)
From: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
To: Michael Peddemors <michael@linuxmagic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Just FYI...
In-Reply-To: <990544782.24176.20.camel@mistress>
Message-Id: <Pine.A32.3.95.1010522175644.48878J-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 May 2001, Michael Peddemors wrote:

> Hmmmm.. In principle this sounds good, but...
> 
> This doesn't seem to be in best interest.. Taking it to the extreme,
> noone should code the linux kernel for buggy bios's, cards etc anymore
> either..  We should all tell em to upgrade their hardware?
> 
> Almost every software application has made allowances for buggy or
> non-compliance systems.  We should encourage their disuse, but should we
> play god?

[...]

Afaik, ECN can still be disabled to support buggy system. Enableing it by
default is a 'political' statement in the sense that we expect use
of the standard. Unfortunately the linux kernel can't detect miscompliance
on its own (if a site explicitly says: I don't support ECN this would be
already standard compliant).

I don't know about the benefits of the use of ECN, so I can't comment
if it makes sense to enable it by default on several distribs and here on
vger compared with the problems several people may experience.

It's an interesting experiment actually: Is the linux community powerful
enough to force vendors/people to fix their products and deploy updates to
comply to standards or can they just ignore it.
 
Michael.

--

Michael Weller: eowmob@exp-math.uni-essen.de, eowmob@ms.exp-math.uni-essen.de,
or even mat42b@spi.power.uni-essen.de. If you encounter an eowmob account on
any machine in the net, it's very likely it's me.

