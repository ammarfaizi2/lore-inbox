Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318560AbSGaXnG>; Wed, 31 Jul 2002 19:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318564AbSGaXnG>; Wed, 31 Jul 2002 19:43:06 -0400
Received: from dsl-65-186-160-165.telocity.com ([65.186.160.165]:51205 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id <S318560AbSGaXnF>; Wed, 31 Jul 2002 19:43:05 -0400
Date: Wed, 31 Jul 2002 19:42:52 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: trond.myklebust@fys.uio.no, Christoph Hellwig <hch@infradead.org>,
       Bill Davidsen <davidsen@tmr.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] The List, pass #2
Message-ID: <20020731234252.GA14930@fieldses.org>
References: <3D3761A9.23960.8EB1A2@localhost> <Pine.LNX.3.96.1020731133038.10066A-100000@gatekeeper.tmr.com> <20020731185850.A20614@infradead.org> <shsk7nbps2u.fsf@charged.uio.no> <20020731212308.A23828@infradead.org> <15688.18891.446678.320123@charged.uio.no> <1028161904.13048.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028161904.13048.20.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 01:31:44AM +0100, Alan Cox wrote:
> On Wed, 2002-07-31 at 21:34, Trond Myklebust wrote:
> > Care to comment on why it is not GPL compatible? Given that they are
> > interested in merging their code into the standard kernel ASAP, I know
> > that they'd be interested in correcting any incompatibilities.
> 
> The 3 clause BSD though very much a completely free/open license has
> requirements conflicting with the GPL 
> 
> http://www.fsf.org/licenses/license-list.html#GPLIncompatibleLicenses
> http://www.fsf.org/philosophy/bsd.html

The "original BSD license" listed on that page actually has 4 numbered
clauses, number 3 (the "advertising clause") being the conflicting one.
The "modified BSD license", which they link to on the same page, has 3
clauses and *is* GPL compatible.  As far as I can tell, the license we are
using at CITI is nearly word-for-word the "modified BSD license", and is
GPL compatible.

--Bruce Fields
