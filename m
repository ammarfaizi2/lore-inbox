Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbTCYV7m>; Tue, 25 Mar 2003 16:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261447AbTCYV7m>; Tue, 25 Mar 2003 16:59:42 -0500
Received: from kestrel.vispa.uk.net ([62.24.228.12]:58373 "EHLO
	kestrel.vispa.uk.net") by vger.kernel.org with ESMTP
	id <S261434AbTCYV7j>; Tue, 25 Mar 2003 16:59:39 -0500
Message-ID: <3E80D391.9060804@walrond.org>
Date: Tue, 25 Mar 2003 22:09:21 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4-bk OHCI usb doesn't work
References: <3E7E2FFC.9020304@walrond.org> <20030324095547.GC5934@kroah.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I was :(

Thanks for letting me know ;)

Greg KH wrote:
> On Sun, Mar 23, 2003 at 10:06:52PM +0000, Andrew Walrond wrote:
> 
>>Nothing detected in dmesg. acpi enabled, same .config as with 2.4.20, 
>>which works fine.
> 
> 
> Are you trying to build the ohci driver into the kernel, and not as a
> module?  I messed up the makefiles, and this isn't possible right now :(
> 
> thanks,
> 
> greg k-h
> 


