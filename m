Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbVKVTja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbVKVTja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbVKVTja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:39:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57805 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965148AbVKVTj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:39:28 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0511221044340.13959@g5.osdl.org> 
References: <Pine.LNX.4.64.0511221044340.13959@g5.osdl.org>  <Pine.LNX.4.64.0511220856470.13959@g5.osdl.org> <E1Ee0G0-0004CN-Az@localhost.localdomain> <24299.1132571556@warthog.cambridge.redhat.com> <20051121121454.GA1598@parisc-linux.org> <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org> <20051121190632.GG1598@parisc-linux.org> <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org> <20051121194348.GH1598@parisc-linux.org> <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org> <20051121211544.GA4924@elte.hu> <17282.15177.804471.298409@cargo.ozlabs.ibm.com> <1132611631.11842.83.camel@localhost.localdomain> <1132657991.15117.76.camel@baythorne.infradead.org> <1132668939.20233.47.camel@localhost.localdomain> <9497.1132684676@warthog.cambridge.redhat.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 22 Nov 2005 19:38:50 +0000
Message-ID: <10979.1132688330@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> bad hw docs if you have any at all

The same could be said of Linux. The docs there could be a *lot* better.

I wonder... might it be worth creating a Wiki or something on kernel.org in
which kernel docs can be maintained?

David
