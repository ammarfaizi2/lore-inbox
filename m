Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbUJ0O7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbUJ0O7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbUJ0O7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:59:22 -0400
Received: from [195.23.16.24] ([195.23.16.24]:62346 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262475AbUJ0O7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:59:12 -0400
Message-ID: <417FB7BA.9050005@grupopie.com>
Date: Wed, 27 Oct 2004 15:59:06 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add p4-clockmod driver in x86-64
References: <88056F38E9E48644A0F562A38C64FB600333A69D@scsmsx403.amr.corp.intel.com>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB600333A69D@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.11; VDF: 6.28.0.39; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
>>....
> Yes. Clock modulation is not as useful compared to enhanced speedstep.
> But, 
> I feel, it should be OK to have the driver, though it is not really
> useful 
> in common case. It may be useful in some exceptional cases. 

I think I have one of such cases.

I am one of the members of the robotic soccer team from the University 
of Oporto, and a couple of months ago we were looking for new 
motherboards for our robots, because we are starting to need new 
hardware (on-board lan, usb2.0, etc.).

We really don't need excepcional performance, but we really, really need 
low power consumption, so lowering the clock on a standard mainboard 
seemed to be the best cost/performance scenario.

Could this driver be used to keep a standard p4 processor at say 25% 
clock speed at all times?

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
