Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272627AbRHaHs3>; Fri, 31 Aug 2001 03:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272628AbRHaHsS>; Fri, 31 Aug 2001 03:48:18 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:41739 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S272627AbRHaHsM>;
	Fri, 31 Aug 2001 03:48:12 -0400
Date: Fri, 31 Aug 2001 00:46:23 -0700
From: Greg KH <greg@kroah.com>
To: Christopher Ruehl <ruehlc@europe.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb_control/bulk_msg
Message-ID: <20010831004623.A20895@kroah.com>
In-Reply-To: <20010831093641.A1257@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010831093641.A1257@pegasus>; from ruehlc@europe.com on Fri, Aug 31, 2001 at 09:36:41AM +0200
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2001 at 09:36:41AM +0200, Christopher Ruehl wrote:
> ! PLEASE CC to me i'am not registered to this list
> 
> i'll try to use the usb-storage with my Sony DSC
> but since kernel version 2.4.7 it's seems to be brocken.
> 
> look like a problem with the interrupt handling with the
> usb-uhci which shares it's interupt with the sym53c8xx driver.

Does the same thing happen with the uhci (JE) driver?
You will also have better luck asking this on the linux-usb-devel
mailing list.

thanks,

greg k-h
