Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313789AbSDIACC>; Mon, 8 Apr 2002 20:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313791AbSDIACB>; Mon, 8 Apr 2002 20:02:01 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:34564 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313789AbSDIACA>;
	Mon, 8 Apr 2002 20:02:00 -0400
Date: Mon, 8 Apr 2002 16:59:45 -0700
From: Greg KH <greg@kroah.com>
To: Felix Seeger <felix.seeger@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb problems (no /dev/usb)
Message-ID: <20020408235945.GD10263@kroah.com>
In-Reply-To: <200204082106.33705.felix.seeger@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 11 Mar 2002 21:17:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 09:06:33PM +0200, Felix Seeger wrote:
> Hi
> 
> I have tried to install a usb printer but I have no /dev/usb.
> 
> Usb drivers / usb printer installed (in kernel / module)
> 
> Do I have to create the folders /dev/usb and the things that are in there ?

If you are not using devfs, yes.

> Why ? ;)

Welcome to Unix :)

thanks,

greg k-h
