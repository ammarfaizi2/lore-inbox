Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275417AbTHNTjG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275418AbTHNTjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:39:05 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:44968 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S275417AbTHNTjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:39:02 -0400
Message-ID: <3F3BE3E8.7060606@rackable.com>
Date: Thu, 14 Aug 2003 12:32:56 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Narayan Desai <desai@mcs.anl.gov>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-rc2 boot hang
References: <Pine.LNX.4.44.0308141428330.3360-100000@localhost.localdomain> <87znicjegu.fsf@mcs.anl.gov>
In-Reply-To: <87znicjegu.fsf@mcs.anl.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Aug 2003 19:39:00.0838 (UTC) FILETIME=[B5F04060:01C3629B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Narayan Desai wrote:

>>>>>>"Marcelo" == Marcelo Tosatti <marcelo@conectiva.com.br> writes:
>>>>>>            
>>>>>>
>
>  Marcelo> Do you have the NMI watchdog on? If not please turn it on,
>  Marcelo> it should give us useful information.
>
>It is an SMP box APIC turned on, so i think this support is already in
>the kernel. I booted it with nmi_watchdog=1 and it didn't produce any
>extra output, even after waiting...is there anything else i can do?
>thanks...
> 
>  
>
  Try compiling it with ACPI support on;-)

># ACPI Support
>#
># CONFIG_ACPI is not set
>

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


