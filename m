Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbSLZRrd>; Thu, 26 Dec 2002 12:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSLZRrc>; Thu, 26 Dec 2002 12:47:32 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:36869 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263313AbSLZRrb>;
	Thu, 26 Dec 2002 12:47:31 -0500
Date: Thu, 26 Dec 2002 09:51:37 -0800
From: Greg KH <greg@kroah.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM][2.5.52/53][USB] USB Device unusable
Message-ID: <20021226175137.GC8229@kroah.com>
References: <200212241533.21347.spstarr@sh0n.net> <200212241652.45041.spstarr@sh0n.net> <20021224220913.GA3237@kroah.com> <200212241725.15439.spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212241725.15439.spstarr@sh0n.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2002 at 05:25:15PM -0500, Shawn Starr wrote:
> mount reports:
> usbfs on /proc/bus/usb type usbfs (rw)
> 
> /etc/fstab:
> usbfs          /proc/bus/usb  usbfs   defaults    0       0
> 
> well, KDE has a plugin that utilizes libusb, libgphoto2 to manipulate the 
> camera. 

And you are sure that this camera works with Linux?

> I never tried the USB on this machine in 2.5 or 2.4.

Have you tried this camera on any other Linux machine, with any other
kernel?

thanks,

greg k-h
