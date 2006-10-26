Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423511AbWJZNYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423511AbWJZNYB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423513AbWJZNYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:24:01 -0400
Received: from adsl-ull-235-236.42-151.net24.it ([151.42.236.235]:30248 "EHLO
	zeus.abinetworks.biz") by vger.kernel.org with ESMTP
	id S1423511AbWJZNYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:24:00 -0400
Message-ID: <4540B66F.2090801@abinetworks.biz>
Date: Thu, 26 Oct 2006 15:21:51 +0200
From: Gianluca Alberici <gianluca@abinetworks.biz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
References: <1161807069.3441.33.camel@dv>	<1161808227.7615.0.camel@localhost.localdomain>	<1161810392.3441.60.camel@dv> <20061025213355.GG23256@vasa.acc.umu.se>	<1161817118.7615.34.camel@localhost.localdomain>	<20061026032352.GI23256@vasa.acc.umu.se> <m2r6wvusng.fsf@vador.mandriva.com>
In-Reply-To: <m2r6wvusng.fsf@vador.mandriva.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry Vignaud wrote:

>David Weinehall <tao@acc.umu.se> writes:
>
>  
>
>>>>Personally I feel that no matter if they are legal or not, we
>>>>should not cater to such drivers in the first place.  If it's
>>>>trickier to use Windows API-drivers under Linux than to write a
>>>>native Linux driver, big deal...  We don't want Windows-drivers.
>>>>We want native drivers.
>>>>        
>>>>
>>>Neither taint nor _GPL are intended to stop people doing things
>>>that, in the eyes of the masses, are stupid. The taint mark is
>>>there to ensure that they don't harm the rest of us. The FSF view
>>>of freedom is freedom to modify not freedom to modify in a manner
>>>approved by some defining body.
>>>      
>>>
>>Hence my use of the world "Personally".  It's my own opinion that we
>>shouldn't support Windows API-drivers.  I don't think this has
>>anything to do with the FSF view on freedom.  This has to do with
>>the freedom to make a sound technical decision.
>>    
>>
>
>and your freedom to do whatever you want at home isn't restricted by
>the tainting.
>  
>
In fact it is now, because ndiswrapper doesnt load on 2.6.19.
The fact: there's a lot of people who are not gonna be using his wlan
unless they are able to modify the sources.
I wouldnt forget that ndiswrapper is a tool which solves problems. Linux
diffusion is affected by compatibility issues.
I really cant see the benefit for Linux in stop supporting windows NDIS
drivers...there's a lot of hardware which works only by that.

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


