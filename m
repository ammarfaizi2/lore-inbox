Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317639AbSFLGVR>; Wed, 12 Jun 2002 02:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317640AbSFLGVQ>; Wed, 12 Jun 2002 02:21:16 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:34059 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317639AbSFLGVP>;
	Wed, 12 Jun 2002 02:21:15 -0400
Date: Tue, 11 Jun 2002 23:17:20 -0700
From: Greg KH <greg@kroah.com>
To: Adam Luchjenbroers <adam@luchjenbroers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Parallel Port and USB Device Drivers
Message-ID: <20020612061720.GA12689@kroah.com>
In-Reply-To: <20020612052609Z317582-22020+2716@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 15 May 2002 05:11:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 02:58:54PM +0930, Adam Luchjenbroers wrote:
> Could someone tell me where I can find some documentation regarding 
> implementing LPT and USB device drivers.

There's a document in the Documentation/DocBook/ directory called
writing_usb_drivers that should be a good place to start.  Also take a
look at the linux-usb.org site, where a link to the (a bit outdated, but
still quite good) Linux USB Programmers guide is.

One of these days I'll merge the two...

Hope this helps,

greg k-h
