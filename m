Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUIOBML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUIOBML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 21:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266703AbUIOBMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 21:12:10 -0400
Received: from [66.35.79.110] ([66.35.79.110]:8634 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S266684AbUIOBL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 21:11:58 -0400
Date: Tue, 14 Sep 2004 18:11:46 -0700
From: Tim Hockin <thockin@hockin.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, Robert Love <rml@ximian.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915011146.GA27782@hockin.org>
References: <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy> <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <20040915010901.GA19524@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915010901.GA19524@vrfy.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 03:09:01AM +0200, Kay Sievers wrote:
> On Tue, Sep 14, 2004 at 05:07:53PM -0700, Greg KH wrote:
> > On Mon, Sep 13, 2004 at 04:45:53PM +0200, Kay Sievers wrote:
> > > Do we agree on the model that the signal is a simple verb and we keep
> > > only a small dictionary of _static_ signal strings and no fancy compositions?

I don't have any concrete examples right now, but it seems that this is
being locked down pretty tightly for no real reason...

Just a passing thought.
