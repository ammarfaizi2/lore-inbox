Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVDSTFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVDSTFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVDSTFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:05:16 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:15232 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261561AbVDSTFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:05:06 -0400
Date: Tue, 19 Apr 2005 19:07:40 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Open hardware wireless cards
Message-ID: <20050419190740.GA8517@beton.cybernet.src>
References: <20050105192447.GJ5159@ruslug.rutgers.edu> <20050105200526.GL5159@ruslug.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105200526.GL5159@ruslug.rutgers.edu>
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 03:05:26PM -0500, Luis R. Rodriguez wrote:
> On Wed, Jan 05, 2005 at 02:24:47PM -0500, Luis R. Rodriguez wrote:
> <-- snip -->
> 
> > As far as support for the new chipsets goes -- sorry -- we won't be able
> > to support it as I don't think even Conexant has a final well tested
> > linux source base ready for 2.6. And even if we are given a source base
> > there is nothing we can do to get around the need for the closed-source 
> > softmac libs that it relies on. As much as I'd like to support it, I
> > don't want to get a headache to support something I cannot modify so I
> > won't be willing to support a half-opened driver as the atheros driver.
> 
> I'd also like to add...
> 
> For those of you frustrated about our current wireless driver situation
> in open platforms --
> 
> I think we probably will have this trouble with most modern hardware for a while
> (graphics cards, wireless driver, etc). A lot of has to do with patent
> infringement issues, "intellectual property" protection, and other
> business-oriented excuses.
> 
> What I think we probably will have to do is just work torwards seeing if
> we can come up with our own open wireless hardware. I know there was
> a recent thread on lkml about an open video card -- anyone know where
> that ended up?

I got open hardware optical wireless, though it's not a card, just
add-on to existing Ethernet:

http://ronja.twibright.com

Nevertheless it show how to use the free-software toolchain.

Also see GNU Radio.

http://www.gnu.org/software/gnuradio/doc/exploring-gnuradio.html

CL<


