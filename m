Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314600AbSEKIqP>; Sat, 11 May 2002 04:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSEKIqO>; Sat, 11 May 2002 04:46:14 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:43200 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S314600AbSEKIqN>; Sat, 11 May 2002 04:46:13 -0400
Message-ID: <3CDCDC21.60501@notnowlewis.co.uk>
Date: Sat, 11 May 2002 09:53:53 +0100
From: mikeH <mikeH@notnowlewis.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020502
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
CC: Erik Steffl <steffl@bigfoot.com>, linux-kernel@vger.kernel.org
Subject: Re: lost interrupt hell - Plea for Help
In-Reply-To: <Pine.LNX.3.96.1020509132713.1987A-100000@pioneer> <200205101112.g4ABCoX29098@Port.imtp.ilyichevsk.odessa.ua> <3CDC3B90.AADE1835@bigfoot.com> <4.1.20020511103241.00914250@pop.cablewanadoo.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you rip audio tracks to wav files ? If not, this might be a problem 
with the apic on amd chips rather than an IDE problem.

Rudmer van Dijk wrote:

>At 09:32 11-5-02 +0100, mikeH wrote:
>  
>
>>You can try compiling without VIA chipset support, but it makes no 
>>difference.
>>Now, with the latest prepatches, -ac patches and ide patches, I am 
>>getting spurious  "8259A interrupt: IRQ7."
>>all over the place too. Seems like the linux kernel does not play well 
>>with AMD Cpus + VIA chipsets, which
>>is a real shame as thats what all my machines are :(
>>    
>>
>
>It's not only with VIA chipsets, I have an Athlon system with a SIS chipset
>and there I get the spurious  "8259A interrupt: IRQ7." as well...
>luckily the message is only displayed once, but it always appears in the
>first 15 min after startup.
>
>	Rudmer
>
>
>
>  
>



