Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbVLVV0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbVLVV0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVLVV0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:26:49 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1800 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965156AbVLVV0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:26:48 -0500
Date: Thu, 22 Dec 2005 21:26:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nicolas Pitre <nico@cam.org>, Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051222212635.GC5268@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>, Nicolas Pitre <nico@cam.org>,
	Christoph Hellwig <hch@infradead.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Jes Sorensen <jes@trained-monkey.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>,
	David Howells <dhowells@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>
References: <20051222114147.GA18878@elte.hu> <20051222115329.GA30964@infradead.org> <Pine.LNX.4.64.0512221025070.26663@localhost.localdomain> <20051222154012.GA6284@elte.hu> <Pine.LNX.4.64.0512221113560.26663@localhost.localdomain> <20051222164415.GA10628@elte.hu> <20051222165828.GA5268@flint.arm.linux.org.uk> <20051222210446.GA16092@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222210446.GA16092@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 10:04:46PM +0100, Ingo Molnar wrote:
> i think there is some miscommunication here.

Quite possibly.  TBH there's soo much waffle generated on the mutex
stuff over the last few days that I've probably lost track of where
everyone is on it.  Sorry.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
