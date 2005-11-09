Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVKIPsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVKIPsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 10:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVKIPsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 10:48:36 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:17717 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751356AbVKIPsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 10:48:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=lORfb7vXfdxgBibzc9tp93DY9cgE2CFsQDsWGY2PLeky8I0AY3aMvmhxC1aRU57RzhE93QdQgUHnCGI2/3ipCVY+3GG9kZvAMww/GNwp/dBbWp1mWoYk4fpjRafKMZTOoeSzZWMeGAfh6xVJl7y1phdrxH2gfur/mKgBqoqPFV8=
Message-ID: <43721A4E.5020707@gmail.com>
Date: Wed, 09 Nov 2005 16:48:30 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Shaohua Li <shaohua.li@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-git4 suspend fails: kernel NULL pointer dereference
References: <20051006072749.GA2393@spitz.ucw.cz> <20051107164715.GA1534@elf.ucw.cz> <1131411772.3003.1.camel@linux-hp.sh.intel.com> <20051108091254.GE15730@elf.ucw.cz> <4370C21C.6040402@gmail.com> <20051108214840.GA32016@elf.ucw.cz>
In-Reply-To: <20051108214840.GA32016@elf.ucw.cz>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek ha scritto:

>Hi!
>
>  
>
>>>>It's my bad. Thanks for fixing this, Pavel. Maybe patrizio didn't enable
>>>>ACPI sleep.
>>>>   
>>>>
>>>>        
>>>>
>>>Will you take care of pushing that patch to mainline?
>>>      
>>>
>
>  
>
>>i'm so sorry, had a hd problem, i've only got the compiled vmlinux
>>
>>:(((
>>    
>>
>
>That's okay, I was talking to Shaohua. It has already been taken
>care of.
>								Pavel
>  
>
ok,

please notice me when it gets merged in a git release, so i can test.

Patrizio
