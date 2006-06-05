Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932371AbWFEBPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWFEBPj (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 21:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWFEBPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 21:15:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44180 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932363AbWFEBPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 21:15:38 -0400
Date: Sun, 4 Jun 2006 18:15:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linville@tuxdriver.com, Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: wireless (was Re: 2.6.18 -mm merge plans)
Message-Id: <20060604181515.8faa8fcf.akpm@osdl.org>
In-Reply-To: <20060605010636.GB17361@havoc.gtf.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<20060605010636.GB17361@havoc.gtf.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 21:06:36 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> On Sun, Jun 04, 2006 at 01:50:11PM -0700, Andrew Morton wrote:
> > acx1xx-wireless-driver.patch
> > fix-tiacx-on-alpha.patch
> > tiacx-fix-attribute-packed-warnings.patch
> > tiacx-pci-build-fix.patch
> > tiacx-ia64-fix.patch
> > 
> >   It is about time we did something with this large and presumably useful
> >   wireless driver.
> 
> I've never had technical objections to merging this, just AFAIK it had a
> highly questionable origin, namely being reverse-engineered in a
> non-clean-room environment that might leave Linux legally vulnerable.

I never knew that.

<reads changelog>
<reads website>
<reads wiki>

I still don't know that.  Denis, do you know the details?

> If we can clear that hurdle, by all means pass it on to John Linville
> and get it moving towards upstream.

OK, thanks.
