Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317714AbSGPAIl>; Mon, 15 Jul 2002 20:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317715AbSGPAIk>; Mon, 15 Jul 2002 20:08:40 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:18447 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317714AbSGPAIj>;
	Mon, 15 Jul 2002 20:08:39 -0400
Date: Mon, 15 Jul 2002 17:10:44 -0700
From: Greg KH <greg@kroah.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] agpgart splitup and cleanup for 2.5.25
Message-ID: <20020716001044.GB32339@kroah.com>
References: <20020712221744.GG11007@kroah.com> <Pine.GSO.4.21.0207151016530.12594-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0207151016530.12594-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 17 Jun 2002 23:06:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 10:17:22AM +0200, Geert Uytterhoeven wrote:
> > +		printk (KERN_DEBUG "Oops, don't init a 2nd agpgard device.\n");
>                                                            ^^^^^^^
> 							   agpgart?

Fixed in the latest version, thanks.

greg k-h
