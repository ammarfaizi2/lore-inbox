Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262129AbSIYWmP>; Wed, 25 Sep 2002 18:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbSIYWmP>; Wed, 25 Sep 2002 18:42:15 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:13065 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262129AbSIYWmP>;
	Wed, 25 Sep 2002 18:42:15 -0400
Date: Wed, 25 Sep 2002 15:46:12 -0700
From: Greg KH <greg@kroah.com>
To: Matt_Domsch@Dell.com
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: devicefs requests
Message-ID: <20020925224612.GA420@kroah.com>
References: <20BF5713E14D5B48AA289F72BD372D68C1E8C0@AUSXMPC122.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D68C1E8C0@AUSXMPC122.aus.amer.dell.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 05:03:09PM -0500, Matt_Domsch@Dell.com wrote:
> > But what do you do with the usb_bus_type?  Why would your code use
> > anything that is private to the driver core?
> 
> Fair enough.  I actually only need the 64-bit unique ID that the USB device
> provides, and its parent PCI device.

Um, what 64-bit unique id?  USB devices do not have such a thing.

thanks,

greg k-h
