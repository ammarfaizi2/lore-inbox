Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbSLZTXW>; Thu, 26 Dec 2002 14:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbSLZTXW>; Thu, 26 Dec 2002 14:23:22 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:6660
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S263342AbSLZTXV>; Thu, 26 Dec 2002 14:23:21 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Greg KH <greg@kroah.com>
Subject: Re: [PROBLEM][2.5.52/53][USB] USB Device unusable
Date: Thu, 26 Dec 2002 14:33:15 -0500
User-Agent: KMail/1.5.9
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200212241533.21347.spstarr@sh0n.net> <200212241725.15439.spstarr@sh0n.net> <20021226175137.GC8229@kroah.com>
In-Reply-To: <20021226175137.GC8229@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200212261433.16060.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, libgphoto2 reports that my camera is supported. It supports JamCam 
versions 2.0 and 3.0.

I haven't tried it in any other Linux machine.

Shawn.

On Thursday 26 December 2002 12:51 pm, Greg KH wrote:
> On Tue, Dec 24, 2002 at 05:25:15PM -0500, Shawn Starr wrote:
> > mount reports:
> > usbfs on /proc/bus/usb type usbfs (rw)
> >
> > /etc/fstab:
> > usbfs          /proc/bus/usb  usbfs   defaults    0       0
> >
> > well, KDE has a plugin that utilizes libusb, libgphoto2 to manipulate the
> > camera.
>
> And you are sure that this camera works with Linux?
>
> > I never tried the USB on this machine in 2.5 or 2.4.
>
> Have you tried this camera on any other Linux machine, with any other
> kernel?
>
> thanks,
>
> greg k-h


