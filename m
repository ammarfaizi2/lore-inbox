Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSEKIxj>; Sat, 11 May 2002 04:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314637AbSEKIxi>; Sat, 11 May 2002 04:53:38 -0400
Received: from smtp1.wanadoo.nl ([194.134.35.136]:25064 "EHLO smtp1.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S314634AbSEKIxi>;
	Sat, 11 May 2002 04:53:38 -0400
Message-Id: <4.1.20020511104535.009c8c30@pop.cablewanadoo.nl>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.1
Date: Sat, 11 May 2002 10:48:22 +0200
To: mikeH <mikeH@notnowlewis.co.uk>
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: Re: lost interrupt hell - Plea for Help
Cc: Erik Steffl <steffl@bigfoot.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3CDCDC21.60501@notnowlewis.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Never tried to rip audio tracks... will try it after the weekend

I do have local APIC enabled, so it could be that the problem is there...
will build a kernel without apic (after the weekend)

	Rudmer

At 09:53 11-5-02 +0100, mikeH wrote:
>
>Can you rip audio tracks to wav files ? If not, this might be a problem 
>with the apic on amd chips rather than an IDE problem.
>
>Rudmer van Dijk wrote:
>
>>At 09:32 11-5-02 +0100, mikeH wrote:
>>  
>>
>>>You can try compiling without VIA chipset support, but it makes no 
>>>difference.
>>>Now, with the latest prepatches, -ac patches and ide patches, I am 
>>>getting spurious  "8259A interrupt: IRQ7."
>>>all over the place too. Seems like the linux kernel does not play well 
>>>with AMD Cpus + VIA chipsets, which
>>>is a real shame as thats what all my machines are :(
>>>    
>>>
>>
>>It's not only with VIA chipsets, I have an Athlon system with a SIS chipset
>>and there I get the spurious  "8259A interrupt: IRQ7." as well...
>>luckily the message is only displayed once, but it always appears in the
>>first 15 min after startup.
>>
>>	Rudmer

