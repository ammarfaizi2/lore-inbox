Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270423AbRHIRh2>; Thu, 9 Aug 2001 13:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270481AbRHIRhS>; Thu, 9 Aug 2001 13:37:18 -0400
Received: from [65.0.121.190] ([65.0.121.190]:30212 "HELO kroah.com")
	by vger.kernel.org with SMTP id <S270423AbRHIRhH>;
	Thu, 9 Aug 2001 13:37:07 -0400
Date: Thu, 9 Aug 2001 10:36:03 -0700
From: Greg KH <greg@kroah.com>
To: satish kumar <satish_shak@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem in finding default audio driver for USB
Message-ID: <20010809103603.A20133@kroah.com>
In-Reply-To: <20010809070618.90243.qmail@web20305.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010809070618.90243.qmail@web20305.mail.yahoo.com>; from satish_shak@yahoo.com on Thu, Aug 09, 2001 at 12:06:18AM -0700
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 12:06:18AM -0700, satish kumar wrote:
> Hi
> 
>  what is the default USB audio driver avaialble
>  in SUSE Linux 7.1 (Kernel 2.2.18). 
>  how can i make use that for my Audio device (writing
> an USB Audio Device Driver).

The driver is called audio.o.

You might take a look at the Linux USB Guide at
http://www.linux-usb.org/ for more information on how to use USB drivers
on Linux.

greg k-h
