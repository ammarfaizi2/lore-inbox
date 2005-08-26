Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbVHZRb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbVHZRb5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbVHZRb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:31:57 -0400
Received: from quark.didntduck.org ([69.55.226.66]:15825 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S965130AbVHZRb5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:31:57 -0400
Message-ID: <430F5257.4010700@didntduck.org>
Date: Fri, 26 Aug 2005 13:33:11 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
References: <1125069494.18155.27.camel@betsy>
In-Reply-To: <1125069494.18155.27.camel@betsy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> Andrew,
> 
> Of late I have been working on a driver for the IBM Hard Drive Active
> Protection System (HDAPS), which provides a two-axis accelerometer and
> some other misc. data.  The hardware is found on recent IBM ThinkPad
> laptops.
> 
> The following patch adds the driver to 2.6.13-rc6-mm2.  It is
> self-contained and fairly simple.
> 
> Please, apply.
> 
> 	Robert Love
> 

Is there any way to detect that this device is present (PCI, ACPI, etc.) 
without poking at ports?

--
				Brian Gerst
