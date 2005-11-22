Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVKVBWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVKVBWK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVKVBWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:22:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:20445 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964819AbVKVBWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:22:08 -0500
Date: Mon, 21 Nov 2005 17:21:49 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-ID: <20051122012149.GC21015@kroah.com>
References: <20051121225303.GA19212@kroah.com> <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132616132.26560.62.camel@gaston>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 10:35:32AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2005-11-21 at 15:01 -0800, Greg KH wrote:
> 
> > If you, or your company is relying on closed source kernel modules, your
> > days are numbered.  And what are you going to do, and how are you going
> > to explain things to your bosses and your customers, if possibly,
> > something like this patch were to be accepted?
> 
> I'm all about it, but good luck trying to convince ATI and/or nVidia ...

They are not the only ones doing closed source Linux drivers by far.
They just seem to be the most "visible" these days.  It's the other
companies, the ones that know better (or at least have legal departments
that know better) that are doing this for various different/odd hardware
pieces that are the most upsetting to me.

And yes, I do understand the patent issue with the video players these
days.  But what about the hardware OEM companies like IBM and HP that
bundle those graphic adapters in their system, and go off and support
and maintain the systems, running Linux, for big-named customers.
That's a timebomb waiting to go off, as there is some real money behind
those contracts.  They are the people in the position to change things
today, yet they are not :(

We are the people to change things for tomorrow, and we are...

thanks,

greg k-h
