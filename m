Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSDQQwM>; Wed, 17 Apr 2002 12:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSDQQwL>; Wed, 17 Apr 2002 12:52:11 -0400
Received: from borg.kabelfoon.nl ([62.45.45.66]:43783 "HELO borg.kabelfoon.nl")
	by vger.kernel.org with SMTP id <S310206AbSDQQvT>;
	Wed, 17 Apr 2002 12:51:19 -0400
Message-ID: <3CBDB4E2.3050406@kabelfoon.nl>
Date: Wed, 17 Apr 2002 19:46:10 +0200
From: Nick Martens <nickm@kabelfoon.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020404
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 Boot problem
In-Reply-To: <3CB1B505.2010505@kabelfoon.nl> <200204100517.g3A5HhX04634@Port.imtp.ilyichevsk.odessa.ua> <3CB5F98C.7010206@kabelfoon.nl> <200204121056.g3CAuQX13845@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the long time without responding but I haven't had any time lately
I'm not sure how to solve it yet I don't know about that ECC mem problem 
but are there any other devices for which this is typical behaviour or 
even some BIOS setting which may cause this



Denis Vlasenko wrote:
> On 11 April 2002 19:01, Nick Martens wrote:
> 
>>I've tried to do the break thing and then boot after 2 minutes, but the
>>problem remains. Is it passible that due to the HW-reset some device
>>gets resetted too and works fine afterwards ???
> 
> 
> Yes, I can imagine some hw which needs to be warm to operate properly.
> It may be unable to reset/init in cold state.
> 
> Is it true that some types of (ECC?) memory need several read passes over 
> them to initialize?
> --
> vda
> 



