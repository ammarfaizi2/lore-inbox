Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbUBXBmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbUBXBmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:42:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:58540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262124AbUBXBmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:42:06 -0500
Date: Mon, 23 Feb 2004 17:42:05 -0800
From: Chris Wright <chrisw@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, Willy Weisz <weisz@vcpc.univie.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Client looses NFS handle (kernel 2.6.3)
Message-ID: <20040223174205.J22989@build.pdx.osdl.net>
References: <20040221214345.6533eb68.akpm@osdl.org> <1077444724.2944.10.camel@nidelv.trondhjem.org> <20040223142811.I22989@build.pdx.osdl.net> <1077586057.2856.48.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <1077586057.2856.48.camel@nidelv.trondhjem.org>; from trond.myklebust@fys.uio.no on Mon, Feb 23, 2004 at 05:27:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Trond Myklebust (trond.myklebust@fys.uio.no) wrote:
> På må , 23/02/2004 klokka 14:28, skreiv Chris Wright:
> > > 
> > > http://www.fys.uio.no/~trondmy/src/Linux-2.6.x/2.6.3/linux-2.6.3-08-reconnect.dif
> > 
> > Looks nice.  Will this go upstream, or is there still other issue?
> 
> No known issues, so I expect it to go upstream RSN. I just thought it
> would be convenient to make use of the fact that the Connectathon
> inter-vendor testfest is on right now to give it some extra milage first
> ;-).

Heh, sounds good.  Thanks ;-)
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
