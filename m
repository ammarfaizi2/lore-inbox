Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVL3HED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVL3HED (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 02:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVL3HED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 02:04:03 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:54932 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751195AbVL3HEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 02:04:02 -0500
Date: Fri, 30 Dec 2005 08:03:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 12/13] mutex subsystem, VFS [experimental]: convert ->i_sem to ->i_mutex
Message-ID: <20051230070331.GA24224@elte.hu>
References: <20051229210521.GM665@elte.hu> <Pine.LNX.4.64.0512291326230.3298@g5.osdl.org> <20051229213434.GA6106@elte.hu> <Pine.LNX.4.64.0512291340000.3298@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512291340000.3298@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Sign-off has a _correlation_ with authorship, but it in no way implies 
> it. Not the first one, not the middle one, and not the last one.

ok, i've added the proper From: lines to the patches. [sorry about this, 
we used to rely on the 'author is the top of the SOB lines' very early 
when we introduced SOB, and i forgot that we introduced the From: line 
at the top of metadata later on to make it easier for tools. The 
information itself is redundant.]

	Ingo
