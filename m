Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbUJYP1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbUJYP1o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUJYPY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:24:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:36011 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261975AbUJYPUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:20:12 -0400
Date: Mon, 25 Oct 2004 08:14:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@novell.com>
cc: Joe Perches <joe@perches.com>, Larry McVoy <lm@work.bitmover.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <20041025133951.GW14325@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0410250812300.3016@ppc970.osdl.org>
References: <20041019213803.GA6994@havoc.gtf.org> <4d8e3fd3041019145469f03527@mail.gmail.com>
 <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org> <20041023161253.GA17537@work.bitmover.com>
 <4d8e3fd304102403241e5a69a5@mail.gmail.com> <20041024144448.GA575@work.bitmover.com>
 <4d8e3fd304102409443c01c5da@mail.gmail.com> <20041024233214.GA9772@work.bitmover.com>
 <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain>
 <20041025133951.GW14325@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Oct 2004, Andrea Arcangeli wrote:
> 
> as a matter of fact nobody can know how the workflow would be if _all_
> kernel developers would have been able to take advantage of a
> distributed revision control system in the last ~3 years.

.. and nobody knows how the universe would look if the speed of light 
wasn't constant.

Your point is pointless. No such distributed revision control system 
exists. And without BK, the people who have worked on them wouldn't 
largely even understand what's wrong with CVS.

In fact, I find that people largely _still_ don't understand what's wrong
with CVS, and are still trying to just make another CVS thing.

So give Larry the credit he deserves, even if you dislike the license.

		Linus
