Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314146AbSDQWQ4>; Wed, 17 Apr 2002 18:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSDQWQz>; Wed, 17 Apr 2002 18:16:55 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:52241 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314146AbSDQWQy>;
	Wed, 17 Apr 2002 18:16:54 -0400
Date: Wed, 17 Apr 2002 14:15:59 -0700
From: Greg KH <greg@kroah.com>
To: Paul Zimmerman <Paul_Zimmerman@inSilicon.com>
Cc: "'linux-usb-devel@lists.sourceforge.net'" 
	<linux-usb-devel@lists.sourceforge.net>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] USB device support for 2.5.8
Message-ID: <20020417211559.GB2365@kroah.com>
In-Reply-To: <7FD8B823E5024E44B027221DEB34C087536510@scl-exch.phoenix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 20 Mar 2002 18:02:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 02:09:32PM -0700, Paul Zimmerman wrote:
> We already have drivers/usb/hcd for "host controller drivers", how about
> drivers/usb/dcd for "device controller drivers"?

No, the drivers/usb/hcd directory has been moved to drivers/usb/host,
and a few more files were added to it.  Take a look at the drivers/usb/
restructure in 2.5.8.

thanks,

greg k-h
