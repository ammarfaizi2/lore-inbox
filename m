Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265333AbUBFJ0X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 04:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265336AbUBFJ0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 04:26:23 -0500
Received: from mail.gmx.de ([213.165.64.20]:54920 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265333AbUBFJ0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 04:26:21 -0500
X-Authenticated: #4512188
Message-ID: <40235DBA.4030408@gmx.de>
Date: Fri, 06 Feb 2004 10:26:18 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Craig Bradney <cbradney@zip.com.au>
CC: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org>	 <1076026496.16107.23.camel@athlonxp.bradney.info>	 <4022DE3C.1080905@wanadoo.es> <4022E209.3040909@gmx.de>	 <4022E3C8.4020704@wanadoo.es>  <4022E69B.5070606@gmx.de> <1076029281.23586.36.camel@athlonxp.bradney.info>
In-Reply-To: <1076029281.23586.36.camel@athlonxp.bradney.info>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Bradney wrote:
> On Fri, 2004-02-06 at 01:58, Prakash K. Cheemplavam wrote:
> 
>>>There is a way to "activate" cpu Disconnect? or it gets enabled by 
>>>simply applying it?
>>
>>In newer Abit BIOSes there is an option, or you use athcool.
>>
>>
>>
>>>Yes, I have a Abit motherboards, perhaps it's the problem with the bios.
>>
>>I have an Abit NF7-S Rev2 with latest Bios.
> 
> 
> As noted in my last post.. you dont NEED athcool OR Disconnect to get
> stability.. 
> 
> I've only ever run athcool to check the status.. and my BIOS doesnt have
> disconnect.
> 
> A7N8X Deluxe V2 BIOS 1007.. 11 days uptime here.. haven had a crash
> since Ross released those patches ages ago.

WITHOUT Disconnect my System is stable, but hotter when idle, so that is 
not the point. Ross wanted the patched to work with APIC and Disconnect.

DO you guys use APIC (not ACPI)? I use both APIC (and local APIC) and 
ACPI. ACPI is not the problem (unless they break something...) but APIC 
and CPU Disconnect makes trouble on nforce2.

Prakash
