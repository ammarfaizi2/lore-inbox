Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbUALEQi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 23:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266055AbUALEQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 23:16:38 -0500
Received: from ms-smtp-02-smtplb.ohiordc.rr.com ([65.24.5.136]:13966 "EHLO
	ms-smtp-02-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S266052AbUALEQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 23:16:35 -0500
Message-ID: <40021F81.9090602@borgerding.net>
Date: Sun, 11 Jan 2004 23:16:01 -0500
From: Mark Borgerding <mark@borgerding.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen D. Williams" <sdw@lig.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: High Quality Random sources, was: Re: SecuriKey
References: <5117BFF0551DD64884B32EE8CA57D3DB01548A3F@revere.nwpump.com> <200401111446.27403.tabris@tabris.net> <4001ECBE.1020009@lig.net>
In-Reply-To: <4001ECBE.1020009@lig.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disregarding the debates of true vs. pseudo randomness, ( an argument 
best left to cypherpunks, philosophers, and quantum physicists ) -- let 
me repeat the question the original poster asked ...

Does anyone have any info about securikey?  The "white papers" on their 
website are nothing but fluff.
It smells like snake oil to me --  probably just a thumbdrive with an 
authentication driver.

Unless it actually encrypts the hard disk, it can't provide much security.
The system can most likely still be booted from a floppy or cdrom.

-
Mark Borgerding


Stephen D. Williams wrote:

> Impossible?  I think not.  Some "mechanical" devices do exhibit true 
> random capability, especially when enhanced by algorithmic means.
> To wit:  http://www.lavarand.org/
>
> Let me know if you can prove their methods don't provide a true "high 
> quality" random source.
>
> I'd like to see their code as a module with an automatic test to make 
> sure that the random source is high quality.  In this case, that would 
> mean making sure that the cap was not off the camera.
>
> sdw
>
> tabris wrote:
>
>> ...
>>     I should also mention that the problem with 'generating' an OTP 
>> via any mechanical or algorithmic means is impossible as at best an 
>> OTP will only be pseudo-random, and therefore with identical inputs 
>> (assuming it is possible, which we can assume here for the sake of 
>> theory and security), the same OTP can be generated, thus breaking 
>> our assumption/necessity of non-deterministic output.
>>
>>     I'd say more but I'm on my way to work.
>> - --
>> tabris
>> - -
>> I do not know whether I was then a man dreaming I was a butterfly, or
>> whether I am now a butterfly dreaming I am a man.
>>         -- Chuang-tzu
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.2.3 (GNU/Linux)
>>
>> iD8DBQFAAagR1U5ZaPMbKQcRAmo2AJ0Wc6xTLCd/swZYlEO6emktLhOtRgCfUUP5
>> OB4YFi6bh1yrVMzGIoN6XNs=
>> =O/uT
>> -----END PGP SIGNATURE-----
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>  
>>
>
>


