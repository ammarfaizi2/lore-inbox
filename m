Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316968AbSFFOCO>; Thu, 6 Jun 2002 10:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316977AbSFFOCN>; Thu, 6 Jun 2002 10:02:13 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:29704 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S316968AbSFFOCM>; Thu, 6 Jun 2002 10:02:12 -0400
Message-ID: <3CFF6BAE.8080406@loewe-komp.de>
Date: Thu, 06 Jun 2002 16:03:26 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Oliver Xymoron <oxymoron@waste.org>, Mark Mielke <mark@mark.mielke.cc>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <Pine.LNX.4.44.0206051612170.2614-100000@waste.org> <E17FikY-0001fL-00@starship> <3CFF22B2.5050004@loewe-komp.de> <E17Fuy2-0002Fa-00@starship>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On Thursday 06 June 2002 10:52, Peter Wächtler wrote:
> 
>>Daniel Phillips wrote:
>>
>>>Our current block queue design would benefit a lot from the kind of
>>>thinking that would be required to make it realtime.
>>>
>>You know that spinning disks do some recalibrations?
>>
>>Whatever marketing tries to imply with "realtime volumes" - the
>>technology only tries to make better promises (think of AV disks
>>for better sustained rate).
>>
> 
> It's my impression that some do thermal recalibration and some don't:
> 
>    http://www.pctechguide.com/04disks.htm
>    "recalibration"
> 

> 
> The need to turn in reliable performance for multimedia apps seems
> to have made thermal calibration a thing of the past, but thanks for
> raising the issue.
> 

Ok, seems that I am a bit outdated (here) :-)

> 
>>LynxOS (now LynuxWorks) has some patents for priority based IO.
>>
> 
> Oh, more of those one-click realtime patents ;-)  Do you have any
> pointers?
> 

http://www.lynuxworks.com/products/whitepapers/patentedio.php3

In the upper right corner you can see the patent number. Try
a search for patent on this side.

