Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbSJJUqe>; Thu, 10 Oct 2002 16:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264011AbSJJUqe>; Thu, 10 Oct 2002 16:46:34 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:23566 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264010AbSJJUqd>;
	Thu, 10 Oct 2002 16:46:33 -0400
Date: Thu, 10 Oct 2002 13:48:11 -0700
From: Greg KH <greg@kroah.com>
To: Michael Steil <mist@c64.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Xbox Linux Kernel Patches Questions
Message-ID: <20021010204811.GO26635@kroah.com>
References: <CE3A2942-DC8C-11D6-B7BF-003065E1FB16@c64.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE3A2942-DC8C-11D6-B7BF-003065E1FB16@c64.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 10:13:56PM +0200, Michael Steil wrote:
> 
> 2) Xpad & remote control drivers
> The Xpad (Xbox gamepad) driver module is already available in your 
> latest development kernel, we can soon add additional or updated 
> drivers for Xbox-specific (USB) hardware.

I'll gladly look over any USB drivers or changes.  Feel free to send
them to the linux-usb-devel list when you feel they are ready to be
added to the tree.

thanks,

greg k-h
