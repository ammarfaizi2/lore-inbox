Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313938AbSDPW67>; Tue, 16 Apr 2002 18:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313939AbSDPW66>; Tue, 16 Apr 2002 18:58:58 -0400
Received: from granite.he.net ([216.218.226.66]:28432 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id <S313938AbSDPW6z>;
	Tue, 16 Apr 2002 18:58:55 -0400
Date: Tue, 16 Apr 2002 15:58:52 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB device support for 2.5.8
Message-ID: <20020416155852.B11902@kroah.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020416155433.A11902@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.20 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 03:54:33PM -0700, Greg KH wrote:
> 
> These changesets add USB device support to the kernel.  It is the Lineo
> code cleaned up a bit and dropped into the drivers/usb/device/
> directory.  Over time, the code will migrate into other usb directories
> as the core of the device and host code merge together.  This release
> provides a version that builds properly, and provides a good base for
> people to start working with.
> 
> Thanks to Stuart Lynne from Lineo for releasing this code and working to
> have it included in the tree.
> 
> Pull from:  bk://linuxusb.bkbits.net/usbd-2.5

These changesets can be found in a single patch at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.5/usbd-2.5.8.patch.gz
for those who don't want to mess with Bitkeeper.

thanks,

greg k-h
