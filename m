Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310441AbSDEBWM>; Thu, 4 Apr 2002 20:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310654AbSDEBWB>; Thu, 4 Apr 2002 20:22:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47878 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310441AbSDEBV5>; Thu, 4 Apr 2002 20:21:57 -0500
Date: Thu, 4 Apr 2002 17:21:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>,
        Larry McVoy <lm@bitmover.com>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <200204050103.g3513k3334779@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.33.0204041720210.1546-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Apr 2002, Albert D. Cahalan wrote:
> 
> So then something like this...
> 
> alias ls='/bin/ls --ignore=SCCS'

Oh, that's very useful. Considering that everything else still finds them, 
like find, shell autocompletion etc.

The only thing "--ignore=xxx" is useful for is hackers that want to break 
into your system and hide their files.

		Linus

