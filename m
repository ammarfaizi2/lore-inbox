Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265649AbSKTIJG>; Wed, 20 Nov 2002 03:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbSKTIJG>; Wed, 20 Nov 2002 03:09:06 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:27666 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265649AbSKTIJF>;
	Wed, 20 Nov 2002 03:09:05 -0500
Date: Wed, 20 Nov 2002 00:09:33 -0800
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module device table restoration
Message-ID: <20021120080933.GC22408@kroah.com>
References: <20021120072654.322C02C087@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021120072654.322C02C087@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 06:00:19PM +1100, Rusty Russell wrote:
> Patch from Adam Richter.  I have a nicer solution based on aliases,
> but it requires coordination with USB, PCI and PCMCIA maintainers,
> which is taking time.

Oops, was I supposed to be doing something?  :)

I liked your patch that did the aliases, but had a few questions about
it.  I guess I need to go dig up that email, sorry.

greg k-h
