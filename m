Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTCCXrN>; Mon, 3 Mar 2003 18:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTCCXrN>; Mon, 3 Mar 2003 18:47:13 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:10200 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S261302AbTCCXrN>; Mon, 3 Mar 2003 18:47:13 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@work.bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Arador <diegocg@teleline.es>,
       "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz
Date: Mon, 3 Mar 2003 15:56:12 -0800 (PST)
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
In-Reply-To: <20030303225702.GP16918@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0303031554230.29949-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, Andrea Arcangeli wrote:

> Just curious, this also means that at least around the 80% of merges
> in Linus's tree is submitted via a bitkeeper pull, right?
>
> Andrea

remember how Linus works, all normal patches get copied into a single
large patch file as he reads his mail then he runs patch to apply them to
the tree. I think this would make the entire batch of messages look like
one cset.

David Lang
