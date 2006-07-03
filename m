Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWGCOVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWGCOVR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 10:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWGCOVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 10:21:17 -0400
Received: from havoc.gtf.org ([69.61.125.42]:1193 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751187AbWGCOVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 10:21:16 -0400
Date: Mon, 3 Jul 2006 10:20:50 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
Subject: Re: Gigabyte Quad Royal SLI Agere Gigabit Network Chip Not Supported Under 2.6.x?
Message-ID: <20060703142050.GA17535@havoc.gtf.org>
References: <Pine.LNX.4.64.0607031001530.20402@p34.internal.lan> <1151936084.3108.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151936084.3108.34.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 04:14:43PM +0200, Arjan van de Ven wrote:
> On Mon, 2006-07-03 at 10:09 -0400, Justin Piszcz wrote:
> > Note: I do not have this motherboard currently, I am just looking at 
> > possible motherboards with many PCI-e slots, this one would fit nicely, 
> > however, it does not have a driver built-in to the kernel for the first 
> > gigabit nic.
> > 
> > README: Release Notes for ET1310 Linux Driver
> > v1.2.2 -------------------------------------------------------------
> > 
> > The ET1310 Linux Driver v1.2.2 is a driver which supports the ET1310 
> > Customer Evaluation Board (Revision 1.1) This driver is subject to change 
> > with subsequent releases.
> 
> 
> can you post a URL to the full driver source? I've not seen this driver
> yet, and chances are others haven't either...

Andi Kleen pointed me to it.  Open source, standard vendor-written
crapola code that desperately needs cleaning.

	Jeff



