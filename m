Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267027AbUBFBJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 20:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267101AbUBFBJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 20:09:26 -0500
Received: from lgsx13.lg.ehu.es ([158.227.2.28]:63654 "EHLO lgsx13.lg.ehu.es")
	by vger.kernel.org with ESMTP id S267027AbUBFBJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 20:09:22 -0500
Message-ID: <4022E954.3060300@wanadoo.es>
Date: Fri, 06 Feb 2004 02:09:40 +0100
From: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031206 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Craig Bradney <cbradney@zip.com.au>
CC: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org>	 <1076026496.16107.23.camel@athlonxp.bradney.info>	 <4022DE3C.1080905@wanadoo.es> <4022E209.3040909@gmx.de>	 <4022E3C8.4020704@wanadoo.es>  <4022E69B.5070606@gmx.de> <1076029281.23586.36.camel@athlonxp.bradney.info>
In-Reply-To: <1076029281.23586.36.camel@athlonxp.bradney.info>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Bradney wrote:

>On Fri, 2004-02-06 at 01:58, Prakash K. Cheemplavam wrote:
>  
>
>>>There is a way to "activate" cpu Disconnect? or it gets enabled by 
>>>simply applying it?
>>>      
>>>
>>In newer Abit BIOSes there is an option, or you use athcool.
>>
>>
>>    
>>
>>>Yes, I have a Abit motherboards, perhaps it's the problem with the bios.
>>>      
>>>
>>I have an Abit NF7-S Rev2 with latest Bios.
>>    
>>
Prakash, I have the same motherboard but not the latest bios (I think I 
cannot overclock in the same way when I flashed the latest, so I 
reverted one version). Perhaps I must upgrade and try.

About the "option" you're talking about in the bios, are you talking 
about CPU throttle?

>
>As noted in my last post.. you dont NEED athcool OR Disconnect to get
>stability.. 
>
>I've only ever run athcool to check the status.. and my BIOS doesnt have
>disconnect.
>
>A7N8X Deluxe V2 BIOS 1007.. 11 days uptime here.. haven had a crash
>since Ross released those patches ages ago.
>  
>
Craig, I'm not talking about cpu disconnect because of the stability. I 
have 100% stability here with the two patches mentioned before in this 
thread. I was talking about my cpu showing temperatures between 53 and 
64º, what I think is very high.
