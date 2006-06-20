Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWFTNYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWFTNYH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 09:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWFTNYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 09:24:07 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:8967 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750797AbWFTNYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 09:24:05 -0400
Date: Tue, 20 Jun 2006 09:23:15 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Michael Buesch <mb@bu3sch.de>
Cc: Chris Wright <chrisw@sous-sol.org>, stable@kernel.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17.1
Message-ID: <20060620132310.GA3114@tuxdriver.com>
References: <20060620101350.GE23467@sequoia.sous-sol.org> <200606201235.19811.mb@bu3sch.de> <20060620104416.GG23467@sequoia.sous-sol.org> <200606201256.27252.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606201256.27252.mb@bu3sch.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 12:56:26PM +0200, Michael Buesch wrote:
> On Tuesday 20 June 2006 12:44, Chris Wright wrote:
> > * Michael Buesch (mb@bu3sch.de) wrote:
> > > On Tuesday 20 June 2006 12:13, Chris Wright wrote:
> > > > We (the -stable team) are announcing the release of the 2.6.17.1 kernel.
> > > 
> > > Please consider inclusion of the following patch into 2.6.17.2:
> > > 
> > > It fixes a possible crash. Might be triggerable in networks with
> > > heavy traffic. I only saw it once so far, though.
> > 
> > I didn't notice that it made it to Linus' tree yet.  Can you make sure
> > to push it up, and I'll queue it for -stable.
> 
> It is in -mm and I think John Linville also queued it upstream
> through Jeff to Linus.
> >From my perspective, everything is done ;)

I haven't quite done my part yet, but I intend to do so.  I think
this is a fine candidate for -stable.

John
-- 
John W. Linville
linville@tuxdriver.com
