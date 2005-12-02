Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbVLBRvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVLBRvG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 12:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbVLBRvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 12:51:06 -0500
Received: from kirby.webscope.com ([204.141.84.57]:649 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1750839AbVLBRvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 12:51:05 -0500
Message-ID: <43908900.5070504@m1k.net>
Date: Fri, 02 Dec 2005 12:48:48 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gcoady@gmail.com
CC: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Linus Torvalds <torvalds@osdl.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       list linux-kernel <linux-kernel@vger.kernel.org>, middelin@polyware.nl
Subject: Re: Linux 2.6.15-rc4
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org> <1133445903.16820.1.camel@localhost> <Pine.LNX.4.64.0512010759571.3099@g5.osdl.org> <6f6293f10512011112m6e50fe0ejf0aa5ba9d09dca1e@mail.gmail.com> <Pine.LNX.4.64.0512011125280.3099@g5.osdl.org> <438F6DFF.2040603@eyal.emu.id.au> <Pine.LNX.4.64.0512011347290.3099@g5.osdl.org> <862vo198it7molqvq5ign38qmncmjk3bo5@4ax.com> <1133523910.6842.3.camel@localhost> <k611p19dv1peeb38a4krlqnib1f0pemj4b@4ax.com>
In-Reply-To: <k611p19dv1peeb38a4krlqnib1f0pemj4b@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:

>On Fri, 02 Dec 2005 09:45:10 -0200, Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:
>
>  
>
>>Em Sex, 2005-12-02 às 10:37 +1100, Grant Coady escreveu:
>>    
>>
>>>On Thu, 1 Dec 2005 13:53:28 -0800 (PST), Linus Torvalds <torvalds@osdl.org> wrote:
>>>
>>>>There are a couple of in-tree drivers that it would be interesting to 
>>>>hear about too. In particular, all these files:
>>>>        
>>>>
>>>...
>>>      
>>>
>>>>	drivers/media/video/zr36120.c
>>>>        
>>>>
>>Grant, you were supposed to fix it [1]. As discussed before, if this is not maintained anymore, just drop it. 
>>    
>>
>I gave up on it, offered to kill it for 2.6.14-rc2-mm1, you want a 
>freshened removal patch?
>  
>
No, Mauro, Pauline already told us that she's working on it.....

Poor Pauline, about once a month someone wants to nuke ZR36120.

Instead of nuking it, let's just mark it BROKEN for now...

Pauline, what's the status?

-Mike
