Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264583AbSIQWAK>; Tue, 17 Sep 2002 18:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSIQWAJ>; Tue, 17 Sep 2002 18:00:09 -0400
Received: from ns1.cypress.com ([157.95.67.4]:58796 "EHLO ns1.cypress.com")
	by vger.kernel.org with ESMTP id <S264583AbSIQWAJ>;
	Tue, 17 Sep 2002 18:00:09 -0400
Message-ID: <3D87A6E3.5090407@cypress.com>
Date: Tue, 17 Sep 2002 17:04:19 -0500
From: Thomas Dodd <ted@cypress.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@bitwizard.nl>
CC: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: Problems accessing USB Mass Storage
References: <1032261937.1170.13.camel@stimpy.angelnet.internal> <20020917151816.GB2144@kroah.com> <3D876861.9000601@cypress.com> <20020917174631.GD2569@kroah.com> <20020917234302.A26741@bitwizard.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rogier Wolff wrote:
> On Tue, Sep 17, 2002 at 10:46:31AM -0700, Greg KH wrote:
> 
>>On Tue, Sep 17, 2002 at 12:37:37PM -0500, Thomas Dodd wrote:
>>
>>>I get the feeling it's not a true mass storage device.
>>
>>Sounds like it.
> 
> 
> Nope. Sure does sound like it's a mass storage device. And it works
> too. 
> 
> The kernel managed to read the partition table off it, and got
> one valid partition: sda1. 

Accept that you cannot read data from the device. At all.
Even dd fails. And the windows drivers work (using XP
in vmware it think it was) correctly on this same device.

	-Thomas

