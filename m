Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264629AbUE2TQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbUE2TQs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 15:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbUE2TQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 15:16:48 -0400
Received: from lucidpixels.com ([66.45.37.187]:56961 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S264629AbUE2TQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 15:16:45 -0400
Date: Sat, 29 May 2004 15:16:36 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Len Brown <len.brown@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dell GX1 500 MHZ locked up with Kernel 2.4.26 due to ACPI --
 Also: IPTables question.
In-Reply-To: <1085637598.17692.53.camel@dhcppc4>
Message-ID: <Pine.LNX.4.60.0405291516130.1611@p500>
References: <A6974D8E5F98D511BB910002A50A6647615FC7D4@hdsmsx403.hd.intel.com>
 <1085637598.17692.53.camel@dhcppc4>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I had ACPI off in the BIOS, please disregard this post.

On Thu, 27 May 2004, Len Brown wrote:

> On Wed, 2004-05-26 at 06:54, Justin Piszcz wrote:
>
>> I previously have had a > 190 day uptime (without ACPI in the kernel,
>> an older kernel of course, but I believe it is ACPI that caused the
>> problem).
>
> Can you send the dmesg for when you have ACPI enabled?
> Does /proc/interrutps show that you are getting some kind
> of acpi events?
>
> Note that ACPI has a number of drivers, eg. processor, thermal etc.
> that you can unload or unconfig to see if the problem lies there.
>
> Note also that you should be able to boot the ACPI enabled kernel with
> "acpi=off" to completely disable anyting ACPI in that kernel.
>
> cheers,
> -Len
>
>
