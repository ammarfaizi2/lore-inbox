Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264759AbSKEHYU>; Tue, 5 Nov 2002 02:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264768AbSKEHYU>; Tue, 5 Nov 2002 02:24:20 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:2062 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264759AbSKEHYU>;
	Tue, 5 Nov 2002 02:24:20 -0500
Date: Mon, 4 Nov 2002 23:27:08 -0800
From: Greg KH <greg@kroah.com>
To: john slee <indigoid@higherplane.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dx2xx.c ?
Message-ID: <20021105072708.GB11769@kroah.com>
References: <20021104113649.GA17478@higherplane.net> <20021104195150.GI6635@kroah.com> <20021105065628.GJ19015@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105065628.GJ19015@higherplane.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 05:56:28PM +1100, john slee wrote:
> On Mon, Nov 04, 2002 at 11:51:50AM -0800, Greg KH wrote:
> > There are a number of different user programs that obsolete the dx2xx.c
> > driver.  You have pointed out that gphoto2 works nicely :)
> 
> a number of?  what is there besides gphoto2? (which doesn't work nicely
> by the way, deletion of files is a pretty basic requirement)

There is a Java application somewhere that works quite well (or so I've
been told, I don't have a device to try it out with.)  Ah, here it is:
	http://jphoto.sourceforge.net/

Try asking the author of that program about it, as he is also the author
of the dx2xx.c driver and asked it to be removed from the kernel :)

Good luck,

greg k-h
