Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267226AbSK3JEN>; Sat, 30 Nov 2002 04:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbSK3JEN>; Sat, 30 Nov 2002 04:04:13 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:32522 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267226AbSK3JEM>;
	Sat, 30 Nov 2002 04:04:12 -0500
Date: Sat, 30 Nov 2002 01:03:06 -0800
From: Greg KH <greg@kroah.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Patch/resubmit(2.5.50): Eliminate pci_dev.driver_data
Message-ID: <20021130090306.GV17065@kroah.com>
References: <20021129174241.A333@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021129174241.A333@baldur.yggdrasil.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 05:42:41PM -0800, Adam J. Richter wrote:
> 	This is the third time I'm posting this patch.  The only
> comments anyone has made about it were from Greg Kroah-Hartmann, which
> were in favor of integrating it.  Can we please get this integrated
> already?  I want to try some more changes to pci.h and I'd rather keep
> the patches separate.

Sorry for the long delay, been working on other things...

I've finally added this to my trees, and will be sending it on to Linus.

thanks for your patience.

greg k-h
