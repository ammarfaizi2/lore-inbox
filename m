Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280351AbRKJAXE>; Fri, 9 Nov 2001 19:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280054AbRKJAWy>; Fri, 9 Nov 2001 19:22:54 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:34824 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280053AbRKJAWn>;
	Fri, 9 Nov 2001 19:22:43 -0500
Date: Fri, 9 Nov 2001 17:22:24 -0800
From: Greg KH <greg@kroah.com>
To: Daniel Ceregatti <vi@sh.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MS Natural keyboard extra keys using usb
Message-ID: <20011109172223.A10635@kroah.com>
In-Reply-To: <3BEC3B3A.6040005@sh.nu> <20011109170008.A10527@kroah.com> <3BEC7180.5010908@sh.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BEC7180.5010908@sh.nu>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 13 Oct 2001 00:21:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 04:14:56PM -0800, Daniel Ceregatti wrote:
> Here is a snippet from lsmod:
> 
> keybdev                 1728   0  (unused)
> 
> If I remove that module, the keyboard ceases to function. I have to ssh 
> in and re-insert it. I have no idea why it says unused.
> 
> The module is loaded explicitly in rc.sysinit (Redhat 7.1)
> 
> 2.4.9, the kernel where these keys work, uses the same driver.

Hm, I'd recommend asking this on the linux-usb-devel list, which is
where the keyboard and HID developers are.

thanks,

greg k-h
