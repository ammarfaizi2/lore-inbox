Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbTIKQ3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbTIKQ3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:29:50 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:42641 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261394AbTIKQ3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:29:49 -0400
Date: Thu, 11 Sep 2003 17:29:06 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Ulrich Drepper <drepper@redhat.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       davem@redhat.com
Subject: Re: [PATCH] Re: today's futex changes
Message-ID: <20030911162906.GB29532@mail.jlokier.co.uk>
References: <20030910113929.GA21945@mail.jlokier.co.uk> <20030911011647.ACB302C21F@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911011647.ACB302C21F@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> > No, I never use that style, except in futex.c to go along with the
> > style that was already there!  I use Emacs with comments in red-orange :) 
> 
> I'll submit a trivial patch to condense them again: it's an Ingo-ism.
> Comments in my parts of the code are less, um, verbose 8)

Oh, the verbosity is definitely me, only the formatting is Ingo-ism :)

-- Jamie
