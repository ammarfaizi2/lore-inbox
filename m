Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUAAREM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 12:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbUAAREM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 12:04:12 -0500
Received: from lbo.net1.nerim.net ([62.212.103.219]:4306 "EHLO
	gyver.homeip.net") by vger.kernel.org with ESMTP id S264526AbUAAREJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 12:04:09 -0500
Message-ID: <3FF45307.7070508@inet6.fr>
Date: Thu, 01 Jan 2004 18:04:07 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Derek Foreman <manmower@signalmarketing.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: best AMD motherboard for Linux
References: <3FEF0AFD.4040109@yahoo.com> <20031228172008.GA9089@c0re.hysteria.sk> <3FEF0AFD.4040109@yahoo.com> <20031228174828.GF3386@DervishD> <20031229165620.GF30794@louise.pinerecords.com> <Pine.LNX.4.58.0312301144340.467@uberdeity> <20031230194203.GA8062@louise.pinerecords.com> <Pine.LNX.4.58.0312301354130.765@uberdeity> <20031231093929.GC8062@louise.pinerecords.com> <Pine.LNX.4.58.0312310914170.473@uberdeity>
In-Reply-To: <Pine.LNX.4.58.0312310914170.473@uberdeity>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Foreman wrote the following on 01/01/2004 07:15 AM :

>On Wed, 31 Dec 2003, Tomas Szepe wrote:
>
>  
>
>>On Dec-30 2003, Tue, 18:46 -0600
>>Derek Foreman <manmower@signalmarketing.com> wrote:
>>
>>    
>>
>>>His primary requirement was that it (the motherboard) work well with
>>>linux.  He stated that he was capable of installing drivers if he had to,
>>>but it would be even better if it wasn't required.
>>>
>>>Open source drivers, or whether nvidia fits your idea of a "linux
>>>supporting company" were not on the stated list of requirements.
>>>      
>>>
>>Indirectly they were, if you admit that opensource drivers are "better"
>>for Linux users.  The person's goal was, let me quote, "to make sure
>>I get the hardware that works best with Linux."  I suggested they avoid
>>nVidia, because _my opinion_ is that binary-only drivers do not "work best."
>>    
>>
>
>I think we're just going to have to disagree on what "work best" means.  I
>choose to interpret it as a measure of driver functionality and
>performance.
>
>Your definition of "work best" is based on a political agenda, and not on
>technical merit.
>
>  
>

Linux isn't a closed-source system where binary APIs are frozen, so 
working best with a set of specific kernels (and I don't even say kernel 
versions, I *mean* kernels, just search for threads on nvidia with 
kernels built with some perfectly legit gcc flags) doesn't mean it is 
working best with Linux.
What if Nvidia goes bankrupt in the future like 3DFX did, what do you do 
with your card ? throw it away ?

I type this e-mail on a Sony PCG-GRT785B laptop which happen to use a 
Geforce Go 420 chip. Until the 5328 nvidia driver, I couldn't even 
switch to a text console after starting X (search for this type of 
problems and you'll see that the laptop support is really lacking in 
their drivers). Even now software suspend is out of the question when 
the nvidia kernel module is loaded (even with X stopped). I was aware of 
the fact that I could encounter these problems when I purchased the 
laptop and was ready to use the OSS XFree driver without 3D support 
(unfortunately I found out that the ones shipped with RH9 don't work), 
so I assume them, but it's hardly what I'll call "working best"...

There's nothing political in saying that binary drivers don't work best. 
In fact it assumes a minimum understanding of the technical aspects 
involved in a Linux kernel to understand *why* they can't work best...

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 

