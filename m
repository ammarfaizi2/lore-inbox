Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUCUP1F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 10:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbUCUP1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 10:27:04 -0500
Received: from 62.79.102.158.adsl.arc.worldonline.dk ([62.79.102.158]:15889
	"EHLO mail.bitplanet.net") by vger.kernel.org with ESMTP
	id S263664AbUCUP1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 10:27:03 -0500
Message-ID: <405DB433.30409@bitplanet.net>
Date: Sun, 21 Mar 2004 16:26:43 +0100
From: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@bitplanet.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI IRQ routing problems with Thinkpad T40
References: <A6974D8E5F98D511BB910002A50A6647615F5EEF@hdsmsx402.hd.intel.com> <1079839652.7279.845.camel@dhcppc4>
In-Reply-To: <1079839652.7279.845.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
>>I've been trying to track down a problem where an interrupt from a
>>cardbus card is being routed incorrectly.
> 
> Kristian,
> Please test the "proposed final patch" here:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=1564

Great, that fixes it.

Thanks,
Kristian
