Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266652AbUBRXdl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUBRXdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:33:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:57476 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266652AbUBRXcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:32:25 -0500
Date: Wed, 18 Feb 2004 15:32:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@infradead.org, paulmck@us.ibm.com, arjanv@redhat.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-Id: <20040218153234.3956af3a.akpm@osdl.org>
In-Reply-To: <20040218230055.A14889@infradead.org>
References: <20040216190927.GA2969@us.ibm.com>
	<20040217073522.A25921@infradead.org>
	<20040217124001.GA1267@us.ibm.com>
	<20040217161929.7e6b2a61.akpm@osdl.org>
	<1077108694.4479.4.camel@laptop.fenrus.com>
	<20040218140021.GB1269@us.ibm.com>
	<20040218211035.A13866@infradead.org>
	<20040218150607.GE1269@us.ibm.com>
	<20040218222138.A14585@infradead.org>
	<20040218145132.460214b5.akpm@osdl.org>
	<20040218230055.A14889@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> Yes.  Andrew, please read the GPL, it's very clear about derived works.
> Then please tell me why you think gpfs is not a derived work.

I haven't seen the code.

> > But at the end of the day, if we decide to not export this symbol, we owe
> > Paul a good, solid reason, yes?
> 
> Yes.  We've traditionally not exported symbols unless we had an intree user,
> and especially not if it's for a module that's not GPL licensed.

That's certainly a good rule of thumb and we (and I) have used it before.

What is the reasoning behind it?
