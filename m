Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVADGgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVADGgc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 01:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVADGgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 01:36:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54665 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262290AbVADGgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 01:36:25 -0500
Date: Tue, 4 Jan 2005 06:36:22 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Willy Tarreau <willy@w.ods.org>
Cc: Christoph Hellwig <hch@infradead.org>, Felipe Alfaro Solana <lkml@mac.com>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@stusta.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
Subject: Re: starting with 2.7
Message-ID: <20050104063622.GB26051@parcelfarce.linux.theplanet.co.uk>
References: <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl> <0F9DCB4E-5DD1-11D9-892B-000D9352858E@mac.com> <Pine.LNX.4.61.0501031648300.25392@chimarrao.boston.redhat.com> <5B2E0ED4-5DD3-11D9-892B-000D9352858E@mac.com> <20050103221441.GA26732@infradead.org> <20050104054649.GC7048@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104054649.GC7048@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 06:46:49AM +0100, Willy Tarreau wrote:
> On Mon, Jan 03, 2005 at 10:14:42PM +0000, Christoph Hellwig wrote:
> > > Gosh! I bought an ATI video card, I bought a VMware license, etc.... I 
> > > want to keep using them. Changing a "stable" kernel will continuously 
> > > annoy users and vendors.
> > 
> > So buy some Operating System that supports the propritary software of
> > your choice but stop annoying us.
> 
> That's what he did. But it was not written in the notice that it could stop
> working at any time :-)

Do you want a long list of message-IDs going way, way back?  Ones of Linus'
postings saying that there never had been any promise whatsoever of in-kernel
interfaces staying unchanged...

For fsck sake, people, give it a rest already.  3rd-party kernel modules
are and had always been responsibility of their maintainers, regardless
of licensing, commercial status, etc.  Exported functions and data structures
can and do change; doing out-of-tree development means taking a calculated
risk and being ready to follow these changes.

So yes, it *had* been written.  Many times.  In details.  With feeling.
