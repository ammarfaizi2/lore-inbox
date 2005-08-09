Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbVHIJAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVHIJAF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHIJAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:00:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:48101 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932473AbVHIJAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:00:03 -0400
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, ncunningham@cyclades.com,
       Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <20050809080853.A25492@flint.arm.linux.org.uk>
References: <42F57FCA.9040805@yahoo.com.au>
	 <200508090710.00637.phillips@arcor.de>
	 <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au>
	 <20050809080853.A25492@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 10:53:49 +0200
Message-Id: <1123577631.30257.175.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Can we straighten out the terminology so it's less confusing please?

Well, RAM that isn't managed by standard page counting could be
considered a some sort of weird MMIO :) 

Ben.


