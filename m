Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUG3Gja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUG3Gja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 02:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267635AbUG3Gja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 02:39:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44208 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267632AbUG3Gj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 02:39:27 -0400
Date: Fri, 30 Jul 2004 08:39:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Robert Love <rml@ximian.com>
Cc: "Prakash K. Cheemplavam" <prakashkc@gmx.de>,
       "Bryan O'Sullivan" <bos@serpentine.com>,
       Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
Message-ID: <20040730063920.GH18347@suse.de>
References: <20040728163353.GJ10377@suse.de> <20040728170507.GK10377@suse.de> <1091051858.13651.1.camel@camp4.serpentine.com> <20040729084928.GR10377@suse.de> <1091166553.1982.9.camel@localhost> <20040730055333.GC7925@suse.de> <1091167031.1982.13.camel@localhost> <20040730061005.GF18347@suse.de> <4109E9F8.9080600@gmx.de> <1091169021.2009.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091169021.2009.3.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30 2004, Robert Love wrote:
> On Fri, 2004-07-30 at 08:26 +0200, Prakash K. Cheemplavam wrote:
> 
> > Could it be famd?
> 
> I thought about that, killed it, still happens.
> 
> The only "something is poking the drive" theory does not make sense,
> though, since it consistently works with some CD's and not others.

Well, your io error doesn't correlate that story :-)

But I'm just puzzled. I guess I could re-rip my entire CD collection and
see what happens here.

-- 
Jens Axboe

