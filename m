Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272214AbRIEP6g>; Wed, 5 Sep 2001 11:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272213AbRIEP62>; Wed, 5 Sep 2001 11:58:28 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:55561 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S272214AbRIEP6J>;
	Wed, 5 Sep 2001 11:58:09 -0400
Date: Wed, 5 Sep 2001 08:58:01 -0700
From: Greg KH <greg@kroah.com>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB device not accepting new address
Message-ID: <20010905085801.E13940@kroah.com>
In-Reply-To: <3B95ADBB.78EAB37F@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B95ADBB.78EAB37F@delusion.de>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2001 at 06:44:43AM +0200, Udo A. Steinberg wrote:
> 
> Hello,
> 
> I have just come across another USB address problem, which happens sporadically
> and is not easy to reproduce. It happens sometimes during bootup and is unrelated
> to port overpowering, at other times everything works well. Output below.
> The USB driver is the JE-driver.

What kernel is this?
What happens when you use the usb-uhci.o driver?

greg k-h
