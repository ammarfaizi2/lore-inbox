Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWB0UPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWB0UPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWB0UPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:15:20 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:44448
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932330AbWB0UPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:15:18 -0500
Date: Mon, 27 Feb 2006 12:15:18 -0800
From: Greg KH <greg@kroah.com>
To: Greg KH <gregkh@suse.de>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227201518.GA12262@kroah.com>
References: <20060227190150.GA9121@kroah.com> <200602271952.08949.s0348365@sms.ed.ac.uk> <20060227195727.GA10752@suse.de> <200602272005.17470.s0348365@sms.ed.ac.uk> <20060227201214.GA12111@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227201214.GA12111@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 12:12:14PM -0800, Greg KH wrote:
> On Mon, Feb 27, 2006 at 08:05:17PM +0000, Alistair John Strachan wrote:
> > But even now, devfs is still in the kernel.
> > 
> > Thanks for the answer anyway, I guess this is a non-issue (who will try to use 
> > code that can't be selected via config?).
> 
> Heh, true.  Actually, devfs is working in the kernel,

Oops, ment to say "is not working"...
