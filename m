Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbVLVXLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbVLVXLM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbVLVXLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:11:11 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:10913 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030360AbVLVXLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:11:09 -0500
Date: Fri, 23 Dec 2005 00:10:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Nicolas Pitre <nico@cam.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/10] mutex subsystem, -V5
Message-ID: <20051222231034.GA15406@elte.hu>
References: <20051222153717.GA6090@elte.hu> <Pine.LNX.4.64.0512221134150.26663@localhost.localdomain> <Pine.LNX.4.64.0512220941320.4827@g5.osdl.org> <1135289062.6454.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135289062.6454.3.camel@laptopd505.fenrus.org>
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


* Arjan van de Ven <arjan@infradead.org> wrote:

> something like this?
> 
> (this one is incremental to the patch series; a full one against -rc6 
> is at http://www.fenrus.org/mutex.patch )

thanks - i've integrated this into the -V6 version (which i released 
shortly ago).

	Ingo
