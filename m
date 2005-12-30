Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbVL3BFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVL3BFg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 20:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVL3BFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 20:05:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19693 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751186AbVL3BFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 20:05:35 -0500
Date: Thu, 29 Dec 2005 17:05:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Ryan Anderson <ryan@michonline.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
In-Reply-To: <20051230004608.GA12822@redhat.com>
Message-ID: <Pine.LNX.4.64.0512291702140.3298@g5.osdl.org>
References: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com>
 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com>
 <43B48176.3080509@michonline.com> <20051230004608.GA12822@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Dec 2005, Dave Jones wrote:
> 
> There's a 2.6.15rc7 kernel that some Fedora Core 4 users could download
> and play with right now. I thought it'd be great to get some extra testing
> over the xmas holidays. Unfortunatly, due to the necessary udev upgrade, 
> many users are turned off from testing by the inability to run X after
> installing it.

Can you actually detail this thing a bit more? I'm a FC4 user myself, and 
I'm sure as hell running X too. And that's not even a special X install 
like I used to have, it's bog-standard FC4 afaik.

And I'm definitely running -rc7 (well, not exactly, it's my current git 
tree, so it's -rc7+patches).

So whatever breakage is there, I'd love to know more. It's not entirely 
obvious.

			Linus
