Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280925AbRKOQCG>; Thu, 15 Nov 2001 11:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280929AbRKOQB5>; Thu, 15 Nov 2001 11:01:57 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:36870 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280925AbRKOQBp>;
	Thu, 15 Nov 2001 11:01:45 -0500
Date: Thu, 15 Nov 2001 09:00:23 -0800
From: Greg KH <greg@kroah.com>
To: Martin McWhorter <m_mcwhorter@prairiegroup.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible Bug: 2.4.14 USB Keyboard
Message-ID: <20011115090023.A10511@kroah.com>
In-Reply-To: <3BF2DFBF.6090502@prairiegroup.com> <20011114145312.A6925@kroah.com> <3BF3D029.7070609@prairiegroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF3D029.7070609@prairiegroup.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 18 Oct 2001 15:54:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 08:24:41AM -0600, Martin McWhorter wrote:
> 
> Yes. I appoligize for not being clear. I get the same results with plain 
> 2.4.14 w/out the preemptive patch.

Thanks for the files.  It looks like the USB drivers are being bound to
your devices properly.

What does the kernel log say when you plug in your keyboard?

thanks,

greg k-h
