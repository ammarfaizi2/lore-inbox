Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWE2V4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWE2V4Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWE2V4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:56:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:47494 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751396AbWE2V4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:56:15 -0400
Date: Mon, 29 May 2006 14:43:06 -0700
From: Greg KH <greg@kroah.com>
To: Jon Masters <jonathan@jonmasters.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux Device Driver Kit available
Message-ID: <20060529214306.GA10875@kroah.com>
References: <20060524232900.GA18408@kroah.com> <35fb2e590605280229g76e75419h10717238e15e7347@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fb2e590605280229g76e75419h10717238e15e7347@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2006 at 10:29:12AM +0100, Jon Masters wrote:
> On 5/25/06, Greg KH <greg@kroah.com> wrote:
> Random ideas:
> 
> * Bootable Damn Small Linux (DSL) or similar.

No, I don't want to get into the distro business.  Already do enough of
that work at my day job :)

> * cached LXR (obviously with reduced function).

LXR doesn't look to run without a web server backend, which makes this
very limited.  I'm trying to get jsFind working properly, and then index
the whole kernel source tree with it.  If that happens, we will get a
basic search engine, but without cross references.

Unless someone knows how to do this another way?

thanks,

greg k-h
