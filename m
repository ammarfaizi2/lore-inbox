Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318746AbSHSM5i>; Mon, 19 Aug 2002 08:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318780AbSHSM5i>; Mon, 19 Aug 2002 08:57:38 -0400
Received: from smtp03.web.de ([217.72.192.158]:11534 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S318746AbSHSM5i>;
	Mon, 19 Aug 2002 08:57:38 -0400
Date: Mon, 19 Aug 2002 00:28:21 +0200
From: Lars Ellenberg <l.g.e@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: epox 4g4a+ (i845g and hpt372) with kernel 2.4.x: Ok, now booting the kernel. hangs.
Message-ID: <20020819002821.A12440@johann>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200208181746.30967.jh@ionium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208181746.30967.jh@ionium.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 05:46:30PM +0200, Justin Heesemann wrote:
> Ok. Whenever i try to boot a 2.4 Kernel (i tried the ones provided by the 
> Debian 3.0 boot cd, Knoppix boot cd and a p4 optimized gentoo kernel) It gets 
> as far as:
> 
> Loading kernel..................
> Loading 
> rescue.gz.......................................................................
> ready.
> Uncompressing Linux... Ok, now booting the kernel.
> 
> Then it hangs.
> Is there a way to get more information what exactly it is doing before it 
> hangs ?
dunno. but:

Had a similar problem once, though on different hardware.
adding a mem=<some good amount less than you actually have>
did the trick. after bios update, I could leave it off again.
 (I think mem=480 could do in your case) 

just a thought...

	lge

