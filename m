Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWGCSQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWGCSQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 14:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWGCSQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 14:16:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:33370 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932096AbWGCSQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 14:16:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=NUaAUEtkr+WWd52kCgSeUsr4dPNPYAQxTzXJ308ViXVEHKo+yHWNbZgkGF/XZb2g51K6ImagJbTdiO35K9fsC2hVEIxk4RRWVWDBLSy22ItB9nhoYgj6ef9ATJqPloa0p+hn4smxWJfgir4ox7HTyBN6zwYyf+2yF3ZeX0ZHuGU=
Message-ID: <44A95F12.8080208@gmail.com>
Date: Mon, 03 Jul 2006 21:16:50 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060620)
MIME-Version: 1.0
To: Daniel Bonekeeper <thehazard@gmail.com>
CC: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>	 <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com> <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com>
In-Reply-To: <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Bonekeeper wrote:
> Hello Alon !
> Unfortunately I don't have an accessible thinkpad laptop (luckly the
> external usb devices may work the same way). From the USB readers at
> http://www.upek.com/products/usb.asp, which one do you think that fits
> better the hardware on your laptop ?

I think that the TCRE3C is similar to the laptop one. I also 
hope that it is the same... Also the laptop integrated one 
is USB device.

Here is my device information:

Bus 003 Device 011: ID 0483:2016 SGS Thomson Microelectronics
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.00
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x0483 SGS Thomson Microelectronics
   idProduct          0x2016
   bcdDevice            0.01
   iManufacturer           1 STMicroelectronics
   iProduct                2 Biometric Coprocessor
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0004  1x 4 bytes
         bInterval              20


> I was looking for any place that sells those devices and I could not
> find any online (even though I found lots of SDK and matching engines
> that supports them, like VeriFinger).
> 
> Is there any place where I can buy one of those readers ?

Oh... I really don't know...
You can buy a new laptop :)

Best Regards,
Alon Bar-Lev.

