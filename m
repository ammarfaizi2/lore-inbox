Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVL3AcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVL3AcV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 19:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVL3AcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 19:32:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21991 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751177AbVL3AcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 19:32:21 -0500
Date: Thu, 29 Dec 2005 16:32:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
In-Reply-To: <43B4774F.7030703@wolfmountaingroup.com>
Message-ID: <Pine.LNX.4.64.0512291628530.3298@g5.osdl.org>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
 <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com>
 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com>
 <43B453CA.9090005@wolfmountaingroup.com> <Pine.LNX.4.64.0512291541420.3298@g5.osdl.org>
 <43B46078.1080805@wolfmountaingroup.com> <Pine.LNX.4.64.0512291603500.3298@g5.osdl.org>
 <43B4774F.7030703@wolfmountaingroup.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Dec 2005, Jeff V. Merkey wrote:
> 
> The fact that Oracle and IBM support apps on Linux are Freeloading? Baloney!

Jeff, give it a rest.

Oracle and IBM haven't been complaining, have they? Oracle mostly does 
user-space stuff (that doesn't change), and has been pretty good about 
their Oracle-fs too - they're even actively discussing "git" issues on the 
git mailing list, and asking for help, and just generally being good 
members of the community.

And IBM engineers are part of the people who change internal kernel 
interfaces in order to make it work better for them.

Pretty much the ONLY people who ever complain about those internal kernel 
interfaces changing are the free-loaders. It's hard for them, because they 
don't want to play according to the rules. Tough. Watch me not care:

   [ Linus sits in his chair, patently not caring ]

See?

		Linus
