Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTIJLkI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 07:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTIJLkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 07:40:08 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:55952 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262524AbTIJLkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 07:40:05 -0400
Date: Wed, 10 Sep 2003 12:39:29 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Ulrich Drepper <drepper@redhat.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       davem@redhat.com
Subject: Re: [PATCH] Re: today's futex changes
Message-ID: <20030910113929.GA21945@mail.jlokier.co.uk>
References: <20030908175140.GC27097@mail.jlokier.co.uk> <20030909040403.C1AA12C0FF@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909040403.C1AA12C0FF@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> BTW, I'm guessing from your preference for multi-line comments that
> you don't use a color-coding editor for source?  I must say that once
> I got used to it, I really prefer comments in green.

You mean the /*
              *
              */ style?

No, I never use that style, except in futex.c to go along with the
style that was already there!  I use Emacs with comments in red-orange :) 

-- Jamie
