Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278381AbRKNVyo>; Wed, 14 Nov 2001 16:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278364AbRKNVyf>; Wed, 14 Nov 2001 16:54:35 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:49156 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S278275AbRKNVy0>;
	Wed, 14 Nov 2001 16:54:26 -0500
Date: Wed, 14 Nov 2001 14:53:12 -0800
From: Greg KH <greg@kroah.com>
To: Martin McWhorter <m_mcwhorter@prairiegroup.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible Bug: 2.4.14 USB Keyboard
Message-ID: <20011114145312.A6925@kroah.com>
In-Reply-To: <3BF2DFBF.6090502@prairiegroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF2DFBF.6090502@prairiegroup.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 17 Oct 2001 21:48:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 03:18:55PM -0600, Martin McWhorter wrote:
> 
> But the USB keyboard does not repond, though the mouse connected through 
> the keyboard hub works.
> 
> Is this a possible bug?

Do you have the same problem without the preemptive patch?

If so, can you send the results of /proc/bus/usb/devices and
/proc/bus/usb/drivers?

thanks,

greg k-h
