Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262636AbSKDTs7>; Mon, 4 Nov 2002 14:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262679AbSKDTs7>; Mon, 4 Nov 2002 14:48:59 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:55052 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262636AbSKDTs6>;
	Mon, 4 Nov 2002 14:48:58 -0500
Date: Mon, 4 Nov 2002 11:51:50 -0800
From: Greg KH <greg@kroah.com>
To: john slee <indigoid@higherplane.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dx2xx.c ?
Message-ID: <20021104195150.GI6635@kroah.com>
References: <20021104113649.GA17478@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104113649.GA17478@higherplane.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 10:36:49PM +1100, john slee wrote:
> did this become "obsolete" in lunix 2.5?  yes, while gphoto2 is a better
> solution (less crap in kernel) it would be nice to have something that
> actually works and doesn't require a huge app to do stuff.  opendis is
> also able to delete files from the camera, while gphoto2 can't...
> 
> what would i have to do to reinstate this driver in 2.5/2.6, bearing in
> mind that i'm primarily a perlite that understands C, rather
> than the other way around...

There are a number of different user programs that obsolete the dx2xx.c
driver.  You have pointed out that gphoto2 works nicely :)

Because of this the driver will not go back into the tree.  If you want
more information, please see the linux-usb-devel list archives.

thanks,

greg k-h
