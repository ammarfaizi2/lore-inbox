Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSKHHlO>; Fri, 8 Nov 2002 02:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbSKHHlO>; Fri, 8 Nov 2002 02:41:14 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:57605 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261664AbSKHHlO>;
	Fri, 8 Nov 2002 02:41:14 -0500
Date: Thu, 7 Nov 2002 23:43:34 -0800
From: Greg KH <greg@kroah.com>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linux-USB-Users <linux-usb-users@lists.sourceforge.net>
Subject: Re: USB broken in 2.5.4[56]
Message-ID: <20021108074334.GE2152@kroah.com>
References: <20021106132022.GA2101@home.ldb.ods.org> <20021106183046.GA23770@kroah.com> <1036701797.2841.17.camel@ldb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036701797.2841.17.camel@ldb>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 09:43:17PM +0100, Luca Barbieri wrote:
> > Anyway, which USB drivers are you using?  That might help us narrow this
> > down a bit.
> 
> speedtouch              8932   3

Oops, I don't think I fixed up that driver based on the other changes
that happened in the USB core.  I'll try to find some time to look at
it, but can't guarantee anything...

thanks,

greg k-h
