Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264439AbSIQRlV>; Tue, 17 Sep 2002 13:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264452AbSIQRlV>; Tue, 17 Sep 2002 13:41:21 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:58116 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264439AbSIQRlV>;
	Tue, 17 Sep 2002 13:41:21 -0400
Date: Tue, 17 Sep 2002 10:46:31 -0700
From: Greg KH <greg@kroah.com>
To: Thomas Dodd <ted@cypress.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       gen-lists@blueyonder.co.uk
Subject: Re: Problems accessing USB Mass Storage
Message-ID: <20020917174631.GD2569@kroah.com>
References: <1032261937.1170.13.camel@stimpy.angelnet.internal> <20020917151816.GB2144@kroah.com> <3D876861.9000601@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D876861.9000601@cypress.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 12:37:37PM -0500, Thomas Dodd wrote:
> 
> I get the feeling it's not a true mass storage device.

Sounds like it.

> The windows drivers talk about TWAIN. And the vendor ID
> is for ViewQuest Technologies, which has a similar camera,
> also with TWAIN drivers. I can send you the drivers from both
> if you think they would help.
> 
> http://www.digitaldreamco.com/shop/epsilon.htm
> http://www.digitaldreamco.com/support/downloads/windows/epsilon.exe
> and
> http://www.vqti.com/VIEWQUEST_ENGLISH/product_detail.asp?NUMBERS=VQ780S
> http://www.vqti.com/viewquest/driver/VQ780S-setup.exe

Windows drivers don't help me much, maybe one of the other usb
developers could help.

Sorry,

greg k-h
