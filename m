Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVBICB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVBICB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 21:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVBICB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 21:01:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39315 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261743AbVBICBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 21:01:17 -0500
Date: Tue, 8 Feb 2005 20:28:03 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: kernel <kernel@crazytrain.com>
Cc: Jean Tourrilhes <jt@hpl.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] Wireless Extension v17 (resend)
Message-ID: <20050208222803.GA11909@logos.cnet>
References: <20050208181637.GB29717@bougret.hpl.hp.com> <20050208180116.GA10695@logos.cnet> <20050208215112.GB3290@bougret.hpl.hp.com> <20050208184145.GD10799@logos.cnet> <1107911344.3863.9.camel@crazytrain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107911344.3863.9.camel@crazytrain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 08:09:04PM -0500, kernel wrote:
> On Tue, 2005-02-08 at 13:41, Marcelo Tosatti wrote:
> > > 	There need to be some unique features in 2.6.X to force people
> > > to upgrade, I guess...
> > 
> > Faster, cleaner, way more elegant, handles intense loads more gracefully, 
> > handles highmem decently, LSM/SELinux, etc, etc...
> > 
> 
> Please *think* before saying this.  It's not always the case.  Firewire
> support in 2.6 kernel has been less than stellar, for one example.  And
> yes, for many, solid 1394 support is a requirement for business.

Well, if it has problems, like every piece of software is expected to have, 
then it should be fixed. 

We all should invest our efforts in having v2.6 the most stable kernel as possible.

I'm sure Ben Collins (1394 maintainer) will appreciate 1394 bug reports and 
he will do his best at fixing them.

> (And we've all seen the testing that has shown both sides (2.4, 2.6)
> have been faster) 
>
> > IMO everyone should upgrade whenever appropriate. 
> > 
> 
> Not sure....on 13 January 2005 Alan Cox posted "Given that base 2.6
> kernels are shipped by Linus with known unfixed
> security holes anyone trying to use them really should be doing some
> careful thinking. In truth no 2.6 released kernel is suitable for
> anything but beta testing until you add a few patches anyway."

Alan means that _mainline_ v2.6 kernel might not be as polished as distribution 
kernels.

He does not mean, at all, that individuals should not upgrade to v2.6 based kernels.

Note his "until you add a few patches anyway".

> How do you answer this, when telling folks "everyone should upgrade
> whenever appropriate."?

Please realize that pretty much all development efforts have been
centered at the v2.6 kernel, and that means a lot.

> Just some random thoughts....from a 2.4 supporter :)

:)
