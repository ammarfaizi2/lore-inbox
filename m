Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWGZQ5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWGZQ5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWGZQ5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:57:42 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:32602 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030195AbWGZQ5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:57:41 -0400
Date: Wed, 26 Jul 2006 10:57:02 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: smp + acpi
In-reply-to: <fa.qBnHwLitfu7Jux0cIbFxbbRJ5m8@ifi.uio.no>
To: Marco Berizzi <pupilla@hotmail.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Message-id: <44C79EDE.7060008@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.55NzOEnhAyNTd6rw92/YGAb9CaI@ifi.uio.no>
 <fa.qBnHwLitfu7Jux0cIbFxbbRJ5m8@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Berizzi wrote:
> Andi Kleen wrote:
> 
>> "Marco Berizzi" <pupilla@hotmail.com> writes:
>>
>> > Since 2.6.15 smp doesn't work anymore without ACPI
>> > May be possible to have a note in "Symmetric multi processing
>> > support" help dialog? Or is it possible to enable ACPI when
>> > SMP is selected?
>>
>> It's probably specific to your system, nothing general.
> 
> Hi Andi,
> 
> Thanks for the reply. I'm compiling linux on a pentinum
> 4 HT 3GHz. 2.6.14 did detect both processor, but all
> kernels > 2.6.15 did not. (at least till 2.6.17.7)

Are you sure you are really using the same configuration? HyperThreading 
has never worked without some amount of ACPI enabled.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

