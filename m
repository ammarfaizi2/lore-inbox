Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265520AbSJSEFW>; Sat, 19 Oct 2002 00:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265521AbSJSEFW>; Sat, 19 Oct 2002 00:05:22 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:39954 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265520AbSJSEFU>;
	Sat, 19 Oct 2002 00:05:20 -0400
Date: Fri, 18 Oct 2002 21:10:47 -0700
From: Greg KH <greg@kroah.com>
To: Nicolas Pitre <nico@cam.org>
Cc: pavel@bug.ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Zaurus support for usbnet.c
Message-ID: <20021019041047.GG12716@kroah.com>
References: <20021018210224.GB9777@kroah.com> <Pine.LNX.4.44.0210182137130.5873-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210182137130.5873-100000@xanadu.home>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 09:38:49PM -0400, Nicolas Pitre wrote:
> On Fri, 18 Oct 2002, Greg KH wrote:
> 
> > Doesn't the usbdnet.c driver support the Zaurus?
> 
> Both the Zaurus and the iPAQ are using a SA1110 which is already supported 
> by usbnet.

Yes, but that's on the client side of USB, right?  Pavel's patch is for
the host side, which I think was supported by usbdnet for the Zaurus.

Or am I just really confused?

greg k-h
