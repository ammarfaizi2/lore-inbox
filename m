Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278615AbRJ1R4e>; Sun, 28 Oct 2001 12:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278617AbRJ1R4P>; Sun, 28 Oct 2001 12:56:15 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:17669 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S278615AbRJ1R4M>;
	Sun, 28 Oct 2001 12:56:12 -0500
Date: Sun, 28 Oct 2001 09:55:27 -0800
From: Greg KH <greg@kroah.com>
To: Solid Silver Panther <silverpanther50@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.13 freezes on boot
Message-ID: <20011028095527.B8059@kroah.com>
In-Reply-To: <F266tyCEyjWk9UlwaM30001198e@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F266tyCEyjWk9UlwaM30001198e@hotmail.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2001 at 01:11:24PM +0000, Solid Silver Panther wrote:
> greetings all,
> 
>  I apologise for the somewhat vague descriptions here, but Im no 
> experienced Kernel Hacker. I'm in my 3rd month of Linux (RedHat 7.1) and was 
> 
> disappointed by the lack of my USB devices (printer and scanner and 
> keyboard). I managed to replace the keyboard for PS/2 one. So, i decided to 
> upgrade kernel to 2.4.13.
> 
> The USB Support I built in is now killing my PC.
> 
> usb.c: Registered new driver iforce
> 
> Thats my last boot message before the system freezes, so Im guessing 2.4.13 
> doesnt properly support the USB stuff I have.
> 
> If theres a fix for that, or if its a common problem that everyone building 
> USB support into their kernels has, I'd appreciate knowing in either case. 
> If it is something im doing hiddeously wrong, please feel free to shout at 
> me.

What happens if you boot without any USB devices plugged in?

thanks,

greg k-h
