Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267019AbSLDSuH>; Wed, 4 Dec 2002 13:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267021AbSLDSuH>; Wed, 4 Dec 2002 13:50:07 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:21392 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267019AbSLDSuG>; Wed, 4 Dec 2002 13:50:06 -0500
Message-ID: <3DEE4AFD.2020608@enib.fr>
Date: Wed, 04 Dec 2002 19:35:41 +0100
From: XI <xizard@enib.fr>
Reply-To: xizard@enib.fr
Organization: http://www.chez.com/xizard
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Bennee <alex@braddahead.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ctrl-Alt-Backspace kills machine not X. ACPI?
References: <1039005946.2366.25.camel@cambridge.braddahead> 	<3DEDF74D.2090204@enib.fr> <1039007556.2217.30.camel@cambridge.braddahead>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bennee wrote:
> On Wed, 2002-12-04 at 12:38, XI wrote:
> 
>>Alex Bennee wrote:
>>
>>>Hi,
>>>
>>>I've been running into problems with my machine locking up in X but
>>>however I have been unable to diagnose it because the Ctrl-Alt-Backspace
>>>key sequence kills my whole machine (i.e. powers it down).
>>>
>>>I've done some searching on google but haven't been able to find any
>>>references except a one errata note for Mandrake that mentions disabling
>>>the APIC which I tried and had no effect.
>>>
>>>The Ctrl-Alt-Backspace sequence will power down my machine at any point
>>>(BIOS Self-test, Grub, Console mode or X) but doesn't to it once Windows
>>>is running. I have a suspicion that this is ACPI related but even with
>>>acpi=off and apm=off flags is can still stop the box which can't be
>>>right. Any pointers? I stand ready to provide any additional data.
>>>
>>
>>Hi,
>>I have a P.C. with short-cut CTRL+ALT+BACKSPACE to shutdown in bios. I 
>>can't find how to disable it, and I don't know if it works under windoze.
>>I think you have the same kind of stupid bios. no?
> 
> 
> The machine is a Fujitsu/Siemens based around the GA-8STXCFS motherboard
> running the latest Award BIOS 6.0PG. And yes, there is no option to
> actually disable ACPI, just change modes for S1 to S3 (shutdown vs
> suspend to RAM IIRC).
> 
> What machine have you got? Do you also experience lockups in X because
> I'm wondering if the 2 are related.
> 
> 

Hi,
I can't remember the brand and the model of the motherboard, but it is 
based on a SIS chipset. (the machine is at 1000km over). The machine 
isn't a Fujitsu, it's a "no name" machine.

I didn't remember any X lookup, I was running a mdk8.1, the machine is 
quite stable.

Xavier

