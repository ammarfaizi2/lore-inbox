Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312980AbSDKWFs>; Thu, 11 Apr 2002 18:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312986AbSDKWFr>; Thu, 11 Apr 2002 18:05:47 -0400
Received: from borg.kabelfoon.nl ([62.45.45.66]:33043 "HELO borg.kabelfoon.nl")
	by vger.kernel.org with SMTP id <S312980AbSDKWFq>;
	Thu, 11 Apr 2002 18:05:46 -0400
Message-ID: <3CB5F98C.7010206@kabelfoon.nl>
Date: Thu, 11 Apr 2002 23:01:00 +0200
From: Nick Martens <nickm@kabelfoon.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020404
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 Boot problem
In-Reply-To: <3CB1B505.2010505@kabelfoon.nl> <200204090939.g399dlX02029@Port.imtp.ilyichevsk.odessa.ua> <3CB30E53.8020905@kabelfoon.nl> <200204100517.g3A5HhX04634@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried to do the break thing and then boot after 2 minutes, but the 
problem remains. Is it passible that due to the HW-reset some device 
gets resetted too and works fine afterwards ???

Denis Vlasenko wrote:
> On 9 April 2002 13:52, Nick Martens wrote:
> 
>>Yes much longer, more like for ever... Is there a way to find out what
>>is causing it other then removing each piece of hardware one by one ??
> 
> 
> Removing hardware is a good idea.
> 
> You may verify heat problem:
> * Turn on your box, press <pause> to freeze boot before it loads OS.
> * Keep it in this state for a minute or two.
> * Power off, wait five second
> * Power on
> 
> If it works flawlweesly after that, it's definitely hw problem.
> --
> vda
> 



