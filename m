Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbVKBT3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbVKBT3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 14:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbVKBT3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 14:29:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:28820 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965193AbVKBT3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 14:29:51 -0500
X-Authenticated: #527675
Message-ID: <436913AB.8060800@gmx.de>
Date: Wed, 02 Nov 2005 20:29:47 +0100
From: Reinhard Nissl <rnissl@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: Re: processor module locks up hyperthreading enabled machine
References: <88056F38E9E48644A0F562A38C64FB6006314A9F@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6006314A9F@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Pallipadi, Venkatesh wrote:

> Hmmmmm.... Please try the latest patch here
> http://bugme.osdl.org/show_bug.cgi?id=5452

Your patch fixed the freeze. Tested with kernel 2.6.14.

I should have mentioned, that my system is equiped with a 
Fujitsu-Siemens Mainboard D1562-A2, most recent BIOS V4.06 R1.09.

I'll try to get this bug fixed in the BIOS, but chances are not that 
good as the board is already "quite old".

Would you please be so kind and drop a few lines about the drawbacks of 
this BIOS bug? What kind of functionality is lost by "ignoring" the 
second CPU at this particular code section?

Thanks for your support!

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
