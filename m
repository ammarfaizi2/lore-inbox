Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293677AbSCKKjn>; Mon, 11 Mar 2002 05:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293676AbSCKKjh>; Mon, 11 Mar 2002 05:39:37 -0500
Received: from [194.228.240.2] ([194.228.240.2]:65284 "EHLO chudak.century.cz")
	by vger.kernel.org with ESMTP id <S293677AbSCKKjS>;
	Mon, 11 Mar 2002 05:39:18 -0500
Message-ID: <3C8C8900.6030605@century.cz>
Date: Mon, 11 Mar 2002 11:37:52 +0100
From: Petr Titera <P.Titera@century.cz>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.8+) Gecko/20020220
X-Accept-Language: en-us
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] ide-scsi compile fix
In-Reply-To: <20020308235852.FAQN13574.tomts7-srv.bellnexxia.net@there> <3C8A0937.4050200@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.16)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> jason wrote:
> 
>> GCC gives an error about an undefined reference to idescsi_init from 
>> ide.c when compiling 2.5.6 with ide scsi emulation enabled, this patch 
>> corrects the problem.
> 
> 
> Tank you for looking after this.
> That was a bit too far reaching on my behalf. You are right if
> one disables module support.
> 

But ide-scsi works even if you remove call of this function from ide.c Why?

Petr Titera

