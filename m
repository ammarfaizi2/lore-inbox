Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264412AbSIQRdO>; Tue, 17 Sep 2002 13:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264417AbSIQRdO>; Tue, 17 Sep 2002 13:33:14 -0400
Received: from ns1.cypress.com ([157.95.67.4]:42475 "EHLO ns1.cypress.com")
	by vger.kernel.org with ESMTP id <S264412AbSIQRdN>;
	Tue, 17 Sep 2002 13:33:13 -0400
Message-ID: <3D876861.9000601@cypress.com>
Date: Tue, 17 Sep 2002 12:37:37 -0500
From: Thomas Dodd <ted@cypress.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
CC: Greg KH <greg@kroah.com>, gen-lists@blueyonder.co.uk
Subject: Re: Problems accessing USB Mass Storage
References: <1032261937.1170.13.camel@stimpy.angelnet.internal> <20020917151816.GB2144@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote:
> On Tue, Sep 17, 2002 at 12:25:37PM +0100, Mark C wrote:
> 
>>mount /dev/sda /mnt/camera
> 
> 
> Did you try /dev/sda1?

High Greg,

Yes he did. Same results.
Same for dd from either sda or sda1 as well.

I get the feeling it's not a true mass storage device.

The windows drivers talk about TWAIN. And the vendor ID
is for ViewQuest Technologies, which has a similar camera,
also with TWAIN drivers. I can send you the drivers from both
if you think they would help.

http://www.digitaldreamco.com/shop/epsilon.htm
http://www.digitaldreamco.com/support/downloads/windows/epsilon.exe
and
http://www.vqti.com/VIEWQUEST_ENGLISH/product_detail.asp?NUMBERS=VQ780S
http://www.vqti.com/viewquest/driver/VQ780S-setup.exe

	-Thomas

