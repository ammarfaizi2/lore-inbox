Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbSJaPnH>; Thu, 31 Oct 2002 10:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262697AbSJaPnH>; Thu, 31 Oct 2002 10:43:07 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:433 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262664AbSJaPmm>;
	Thu, 31 Oct 2002 10:42:42 -0500
Date: Thu, 31 Oct 2002 15:47:18 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       n2m1@ltc-eth1000.torolab.ibm.com, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: What's left over.
Message-ID: <20021031154718.GC27801@bjl1.asuk.net>
References: <OF6C80F3C5.070C630E-ON80256C63.00502DC2@portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6C80F3C5.070C630E-ON80256C63.00502DC2@portsmouth.uk.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard J Moore wrote:
> With the two it is possible to implant tracepoints without having to
> code up specific printks: kprobes can be used to implant a probe,
> the probe handler can call LTT to record the event.

Hey, that _is_ useful.  Me like.  Me spent many times wondering what
gets called when, and hunting heisenbugs masked by printk slowness.

-- Jamie
