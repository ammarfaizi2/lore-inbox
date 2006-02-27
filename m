Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWB0UMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWB0UMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWB0UMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:12:17 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:1168 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932311AbWB0UMQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:12:16 -0500
Date: Mon, 27 Feb 2006 12:12:14 -0800
From: Greg KH <gregkh@suse.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227201214.GA12111@suse.de>
References: <20060227190150.GA9121@kroah.com> <200602271952.08949.s0348365@sms.ed.ac.uk> <20060227195727.GA10752@suse.de> <200602272005.17470.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602272005.17470.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 08:05:17PM +0000, Alistair John Strachan wrote:
> But even now, devfs is still in the kernel.
> 
> Thanks for the answer anyway, I guess this is a non-issue (who will try to use 
> code that can't be selected via config?).

Heh, true.  Actually, devfs is working in the kernel, if you try to use
it you will notice that it does not work anymore.  The fact that no one
has tried to use it and complain about it, makes me _know_ that no one
is using it anymore :)

thanks,

greg k-h
