Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280323AbRKJAAn>; Fri, 9 Nov 2001 19:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280339AbRKJAAd>; Fri, 9 Nov 2001 19:00:33 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:31752 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280323AbRKJAA1>;
	Fri, 9 Nov 2001 19:00:27 -0500
Date: Fri, 9 Nov 2001 17:00:08 -0800
From: Greg KH <greg@kroah.com>
To: Daniel Ceregatti <vi@sh.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MS Natural keyboard extra keys using usb
Message-ID: <20011109170008.A10527@kroah.com>
In-Reply-To: <3BEC3B3A.6040005@sh.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BEC3B3A.6040005@sh.nu>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 12 Oct 2001 23:57:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 12:23:22PM -0800, Daniel Ceregatti wrote:
> 
> Ever since 2.4.10, these keys have stopped working.

Are you sure you are still using the HID keyboard drivers, and not the
usbkbd (boot protocol keyboard) driver?

thanks,

greg k-h
