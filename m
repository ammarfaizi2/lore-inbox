Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVJaQ77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVJaQ77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVJaQ76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:59:58 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:3965 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964787AbVJaQ75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:59:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=fI/hdkwcJBlaRq5DWvNQjt/+NuF1dFB7HD3oNYwV/bCmQdGSy/aFqiSbs/xQlYE/VP2QD+pfI/JW/hSXv0Fr72RR0KfG8Vhr1sLvuyn6Wubbqtk1AKu/b2DIFCZJ7ug/Qqs2ULzZNPBJhKWprvd0n19uRw5vPf+2JHQZR11gWd8=
Message-ID: <43664D88.7050401@gmail.com>
Date: Mon, 31 Oct 2005 17:59:52 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Mike Fowler <linux-kernel@mlfowler.com>,
       "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2579] linux 2.6.* sound problems
References: <53JVy-4yi-19@gated-at.bofh.it> <53Kyw-5Bt-53@gated-at.bofh.it> <53L26-6dC-75@gated-at.bofh.it>
In-Reply-To: <53L26-6dC-75@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fowler ha scritto:
> 
> 
> Ray Lee wrote:
> 
>> On 10/31/05, Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
>>
>>> starting from 2.6.0 (2 years ago) i have the following bug.
>>
>>
>>
>> Well, the problem probably started before then.
>>
>>
>>> link: http://bugzilla.kernel.org/show_bug.cgi?id=2579
>>
>>
>>
>>> Please fix that...2 years' bug!
>>
>>
>>
>> Speaking as a programmer, that's not a lot to go off of to find the
>> bug. I think everyone would agree it's a bug, but we'll need more help
>> from you.
>>
>>
>>> fast summary:
>>> when playing audio and using a bit the harddisk (i.e. md5sum of a 200mb
>>> file) i hear noises, related to disk activity. more hd is used, more
>>> chicks
>>> and ZZZZ noises happen.
>>
>>
> 
> This to me sounds more like an interference issue, something I have seen
> on many laptops (I used to repair them in a previous incarnation). It is
> often referred to as "the 50Hz/60Hz hum" or the "ground loop" see any of
> these:
> 
> -http://www.pcmus.com/power-grounding.htm
> -http://en.wikipedia.org/wiki/Ground_loop_%28electricity%29
> 

not hardware related, as it works with 2.4 and windows
