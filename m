Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbUBFLEY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 06:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265413AbUBFLEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 06:04:24 -0500
Received: from pop.gmx.net ([213.165.64.20]:18854 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265405AbUBFLEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 06:04:22 -0500
X-Authenticated: #4512188
Message-ID: <402374B0.8080907@gmx.de>
Date: Fri, 06 Feb 2004 12:04:16 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dan@reactivated.net>
CC: Craig Bradney <cbradney@zip.com.au>,
       =?ISO-8859-1?Q?Luis_Miguel_G?= =?ISO-8859-1?Q?arc=EDa?= 
	<ktech@wanadoo.es>,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org>	 <1076026496.16107.23.camel@athlonxp.bradney.info>	 <4022DE3C.1080905@wanadoo.es> <4022E209.3040909@gmx.de>	 <4022E3C8.4020704@wanadoo.es>  <4022E69B.5070606@gmx.de>	 <1076029281.23586.36.camel@athlonxp.bradney.info> <40235DBA.4030408@gmx.de> <1076062051.16107.49.camel@athlonxp.bradney.info> <40236F06.5050103@gmx.de> <40236207.7050104@reactivated.net>
In-Reply-To: <40236207.7050104@reactivated.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Prakash K. Cheemplavam wrote:
> 
>> Ok, then it makes sense, so you are using APIc with CPU Disconnect and 
>> Ross' patch. This explains your low idle temps. As I said this config 
>> doesn't work for me.
> 
> 
> Have you experimented with the new apic_tack boot options in Ross's 
> latest patches?
> apic_tack=2 seems to work best for me.

Stupid me. I haven't thoruoughly read the text. I have not activated the 
patch, so I'll try this. thx for pointing out..

Prakash
