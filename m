Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314046AbSDQDyq>; Tue, 16 Apr 2002 23:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314048AbSDQDyp>; Tue, 16 Apr 2002 23:54:45 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:59919 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314046AbSDQDyo>;
	Tue, 16 Apr 2002 23:54:44 -0400
Date: Tue, 16 Apr 2002 19:53:57 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB device support for 2.5.8 (take 2)
Message-ID: <20020417025356.GD29064@kroah.com>
In-Reply-To: <20020416155433.A11902@kroah.com> <20020417025104.GC29064@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 19 Mar 2002 21:38:25 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 07:51:04PM -0700, Greg KH wrote:
> 
> Linus, here is an updated changeset series with the USB device support.
> It removes the arm sa1100 code from the last series, as the USB driver
> in the ARM tree should be used, instead of the previous old version.  I
> will work with the ARM people to merge that into this portion of the
> tree.
> 
> 
> Pull from:  bk://linuxusb.bkbits.net/usbd-2.5

The updated patch for this can be found at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.5/usbd-2.5.8.patch-2.gz

thanks,

greg k-h
