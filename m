Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265436AbUBFNUx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 08:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265320AbUBFNUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 08:20:53 -0500
Received: from pop.gmx.net ([213.165.64.20]:50886 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265431AbUBFNUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 08:20:52 -0500
X-Authenticated: #4512188
Message-ID: <402394AB.5070705@gmx.de>
Date: Fri, 06 Feb 2004 14:20:43 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Craig Bradney <cbradney@zip.com.au>
CC: Daniel Drake <dan@reactivated.net>,
       =?ISO-8859-1?Q?Luis_Miguel_Ga?= =?ISO-8859-1?Q?rc=EDa?= 
	<ktech@wanadoo.es>,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org>	 <1076026496.16107.23.camel@athlonxp.bradney.info>	 <4022DE3C.1080905@wanadoo.es> <4022E209.3040909@gmx.de>	 <4022E3C8.4020704@wanadoo.es>  <4022E69B.5070606@gmx.de>	 <1076029281.23586.36.camel@athlonxp.bradney.info> <40235DBA.4030408@gmx.de>	 <1076062051.16107.49.camel@athlonxp.bradney.info> <40236F06.5050103@gmx.de>	 <40236207.7050104@reactivated.net> <402374B0.8080907@gmx.de>	 <40237765.6080602@gmx.de> <1076071864.1036.3.camel@athlonxp.bradney.info>
In-Reply-To: <1076071864.1036.3.camel@athlonxp.bradney.info>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>OK, I appended apic_tack=2 and yes, it survives several hdparms! Great, 
>>so gonna try if it is really stable.Then I can try =1. CPU cooling down. 
>>Already at 46°C. :-)
>>
>>Not bad,not bad, though I saw a small performace degration: hdparm gives 
>>me 60-61mb/s instead of >62mb/s, but I won't complain. :-)
>>
> 
> 
> Ahh yes.. missing the kernel line argument will make a difference. I'm
> running apic_tack=2 as well. From what I remember =2 was the "better"
> patch option if it made your system stable.

Yes, you're right. So far 2 seems to be pretty stable.Nice. :-)

Prakash
