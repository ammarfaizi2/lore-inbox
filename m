Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVCCP3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVCCP3Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 10:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVCCP3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 10:29:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49412 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261220AbVCCP3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 10:29:11 -0500
Date: Thu, 3 Mar 2005 16:29:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: status of the USB w9968cf.c driver in kernel 2.6?
Message-ID: <20050303152908.GC4608@stusta.de>
References: <20050228231430.GW4021@stusta.de> <1109699163.4224aa5b1e4dc@posta.studio.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109699163.4224aa5b1e4dc@posta.studio.unibo.it>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 06:46:03PM +0100, Luca Risolia wrote:
> Scrive Adrian Bunk <bunk@stusta.de>: 
>  
> > I noticed the following regarding the drivers/usb/media/ov511.c driver: 
>                                                           ^^^^^^^ 
> > - it's not updated compared to upstream: 
>  
> Could you provide more details? 

Sorry, my fault.
I confused this with a different driver.

> > - there's no w9968cf-vpp module in the kernel sources 
>  
> w9968cf-vpp is an optional, gpl'ed module, which can not be included in the 
> mainline kernel, as I explained in the documentation of the driver. 

  Please keep in mind that official kernels do not include the second 
  module for performance purposes.

What exactly does this mean?

Is it useful or not?

> Regards, 
>       Luca 

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

