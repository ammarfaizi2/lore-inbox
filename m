Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265321AbUBFJ3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 04:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbUBFJ3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 04:29:08 -0500
Received: from imap.gmx.net ([213.165.64.20]:24471 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265321AbUBFJ3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 04:29:00 -0500
X-Authenticated: #4512188
Message-ID: <40235E53.4060504@gmx.de>
Date: Fri, 06 Feb 2004 10:28:51 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
CC: Craig Bradney <cbradney@zip.com.au>,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org>	 <1076026496.16107.23.camel@athlonxp.bradney.info>	 <4022DE3C.1080905@wanadoo.es> <4022E209.3040909@gmx.de>	 <4022E3C8.4020704@wanadoo.es>  <4022E69B.5070606@gmx.de> <1076029281.23586.36.camel@athlonxp.bradney.info> <4022E954.3060300@wanadoo.es>
In-Reply-To: <4022E954.3060300@wanadoo.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Miguel García wrote:
> Craig Bradney wrote:
> 
>> On Fri, 2004-02-06 at 01:58, Prakash K. Cheemplavam wrote:
>>  
>>
>>>> There is a way to "activate" cpu Disconnect? or it gets enabled by 
>>>> simply applying it?
>>>>     
>>> I have an Abit NF7-S Rev2 with latest Bios.
>>>   
> 
> Prakash, I have the same motherboard but not the latest bios (I think I 
> cannot overclock in the same way when I flashed the latest, so I 
> reverted one version). Perhaps I must upgrade and try.
> 
> About the "option" you're talking about in the bios, are you talking 
> about CPU throttle?

Nope, it is called cpu disconnect...

> Craig, I'm not talking about cpu disconnect because of the stability. I 
> have 100% stability here with the two patches mentioned before in this 
> thread. I was talking about my cpu showing temperatures between 53 and 
> 64º, what I think is very high.

Do you only have stability with those two patches? I mean WITHOUT 
Disconnect I don't need those patches to have stability (with certain 
kernels...). At least the delay patch is not needed. The timer irq 
mapping patch might be usefull, but i am not 100% sure.

Prakash
