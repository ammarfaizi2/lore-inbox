Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266949AbSK2DlG>; Thu, 28 Nov 2002 22:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbSK2DlG>; Thu, 28 Nov 2002 22:41:06 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:36103 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266949AbSK2DlG>;
	Thu, 28 Nov 2002 22:41:06 -0500
Date: Thu, 28 Nov 2002 19:40:11 -0800
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: David Brownell <david-b@pacbell.net>,
       "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module alias and table support
Message-ID: <20021129034011.GA12711@kroah.com>
References: <3DE53EF6.4080303@pacbell.net> <20021128041136.35CA02C081@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021128041136.35CA02C081@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 02:14:29PM +1100, Rusty Russell wrote:
> 
> Hopefully this is back together: the device-table-to-aliases stuff is
> a separate step which can be argued on its own, and I think will
> probably have to wait for 2.7 unless Greg is going to champion it.
> 
> The real win is simplicity and independence from the kernel
> datastructures (which probably won't change during 2.6 anyway).

Which, imho, is worth championing!  :)

I'm going to be in Austin next week, and I'll have some free time in the
evenings, so I'll try to take a look at your previous patch and see if I
can change it a bit to resolve the minor problems I had with it.

thanks,

greg k-h
