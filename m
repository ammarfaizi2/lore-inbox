Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267940AbUIIWWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267940AbUIIWWs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 18:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267999AbUIIWWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 18:22:48 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:11539
	"EHLO muru.com") by vger.kernel.org with ESMTP id S267940AbUIIWWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 18:22:36 -0400
Date: Thu, 9 Sep 2004 15:28:19 -0700
From: Tony Lindgren <tony@atomide.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, Andi Kleen <ak@suse.de>
Subject: Re: swsusp on x86-64 w/ nforce3
Message-ID: <20040909222818.GB11843@atomide.com>
References: <200409061836.21505.rjw@sisk.pl> <200409082252.38350.rjw@sisk.pl> <20040909011802.GN8142@atomide.com> <200409091219.17347.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409091219.17347.rjw@sisk.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rafael J. Wysocki <rjw@sisk.pl> [040909 03:19]:
> On Thursday 09 of September 2004 03:18, Tony Lindgren wrote:
> > * Rafael J. Wysocki <rjw@sisk.pl> [040908 13:52]:
> > > On Wednesday 08 of September 2004 22:42, Tony Lindgren wrote:
> > > > 
> > > > Just FYI, swsusp works nicely here on my m6805 laptop :)
> > > 
> > > Can you, please, send me your .config?
> > 
> > You can get my current m6805 .config at (I just updated it):
> > 
> > http://www.muru.com/linux/amd64/config
> > 
> 
> Please excuse me, but Is your laptop nforce3-based?  I see that you have set 
> CONFIG_BLK_DEV_VIA82CXXX rather than CONFIG_BLK_DEV_AMD74XX in the .config, 
> which indicates that it's VIA-based.

Yeah, it's VIA chipset.

Tony
