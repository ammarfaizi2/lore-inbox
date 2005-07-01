Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263421AbVGASH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263421AbVGASH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 14:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbVGASH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 14:07:58 -0400
Received: from rly-ip05.mx.aol.com ([64.12.138.9]:53988 "EHLO
	rly-ip05.mx.aol.com") by vger.kernel.org with ESMTP id S263421AbVGASGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 14:06:21 -0400
Message-ID: <42C585CE.1060509@yahoo.co.uk>
Date: Fri, 01 Jul 2005 19:05:02 +0100
From: christos gentsis <christos_gentsis@yahoo.co.uk>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI-X support
References: <42C58203.40606@yahoo.co.uk> <Pine.LNX.4.61.0507011357290.5350@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0507011357290.5350@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 195.93.24.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> On Fri, 1 Jul 2005, christos gentsis wrote:
>
>> Hello
>>
>> I have a friend that his Msc project is related with the development
>> over a PCI-X card. the problem is that he do not know if the Linux
>> kernel support the PCI-X bus. i try to find something related with the
>> PCI-X in the kernel source but i didn't found any file or folder with a
>> relevant name... Does any one know if PCI-X bus supported from Linux and
>> if no how can he patch the kernel to support it...?
>>
>> Thanks
>> Chris
>
>
> Sure PCI-X is just PCI/66 with 64-bits. It's just like PCI/66
> from a software standpoint.
>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by Dictator Bush.
>                  98.36% of all statistics are fiction.
>
so this practically means that hi will plug the card in, install Linux 
and the card will work correctly? because normal PCI i think that is 
32-bit... does the same driver will provide full support?

