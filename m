Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbTIFRos (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 13:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTIFRos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 13:44:48 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:16782 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261316AbTIFRor
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 13:44:47 -0400
Date: Sat, 6 Sep 2003 18:44:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: today's futex changes
Message-ID: <20030906174428.GA11108@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain> <3F5A1A11.5060809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5A1A11.5060809@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> > Does the patch below work for you, Ulrich?
> 
> Indeed it does.  This was so far only on a UP HT machine.  I'll
> hopefully later on can run it on a bigger SMP machine.  Good work.

The bugs fixed in Hugh's patch explain all the symptoms I saw with
your test program.

-- Jamie
