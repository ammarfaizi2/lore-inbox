Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268996AbRHaTT3>; Fri, 31 Aug 2001 15:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbRHaTTM>; Fri, 31 Aug 2001 15:19:12 -0400
Received: from mail.arcor-ip.de ([145.253.2.10]:27052 "EHLO mail.arcor-ip.de")
	by vger.kernel.org with ESMTP id <S268996AbRHaTSs>;
	Fri, 31 Aug 2001 15:18:48 -0400
Date: Fri, 31 Aug 2001 21:18:51 +0200
From: Christopher Ruehl <ruehlc@europe.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb_control/bulk_msg
Message-ID: <20010831211851.A1047@pegasus>
Reply-To: Christopher Ruehl <ruehlc@europe.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010831093641.A1257@pegasus> <20010831004623.A20895@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010831004623.A20895@kroah.com>; from greg@kroah.com on Fri, Aug 31, 2001 at 12:46:23AM -0700
OS: Linux pegasus 2.4.9-ac5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Aug 31, 2001 at 09:36:41AM +0200, Christopher Ruehl wrote:
> > ! PLEASE CC to me i'am not registered to this list
> Does the same thing happen with the uhci (JE) driver?
> You will also have better luck asking this on the linux-usb-devel
> mailing list.

ok, i'll sent it to linux-usb-devel

and it's happen with both, the new and 'old JE' uhci

i'am also took the delay switch on for slow usb-devices
CONFIG_USB_LONG_TIMEOUT=y

but it's doesn't resolve my problem.

thanx for now
-cr

