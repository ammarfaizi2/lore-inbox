Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261702AbSJNO43>; Mon, 14 Oct 2002 10:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261703AbSJNO43>; Mon, 14 Oct 2002 10:56:29 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:41989 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261702AbSJNO43>;
	Mon, 14 Oct 2002 10:56:29 -0400
Date: Mon, 14 Oct 2002 08:02:38 -0700
From: Greg KH <greg@kroah.com>
To: James Courtier-Dutton <jcdutton@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add support for Pentax Still Camera to linux kernel.
Message-ID: <20021014150238.GA6335@kroah.com>
References: <3DAA6CA2.8090008@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAA6CA2.8090008@users.sourceforge.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 05:05:06PM +1000, James Courtier-Dutton wrote:
> This is a very low risk patch.
> Attached patch to "/usr/src/linux/drivers/usb/storage/unusual_devs.h" to 
> enable the "PENTAX OPTIO 430" USB Still Camera to appear as a SCSI 
> /dev/sd* storage device.
> This patch works for my kernel version 2.4.18, but should work just as 
> well unchanged for 2.4.19.
> Patching to 2.5.x has not been tested.
> 
> Please include this patch with all future kernels.

Can you please send this to the usb-storage author and maintainer?  He's
the one that needs to add this.

thanks,

greg k-h
