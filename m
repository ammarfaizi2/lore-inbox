Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVKWUeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVKWUeG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVKWUc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:32:58 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:59178 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932435AbVKWUb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:31:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=cck/ORgv5xjGHowOpfLlrfhFnCjZz7XOvPQRzokTRtdxaFzcfTC0IJ03sLAjkZL9UDjgB0oP0pi33ahO8G+uIKXmZtwpH3+JXHouLy9VGcWINCYh8Ngg1O0VX61x6g/s6aiOz1WGMrnz2pqFLF5fkqCQ2EvtTXZsXf7+zkZbqNc=
Message-ID: <4384D198.7050005@gmail.com>
Date: Wed, 23 Nov 2005 21:31:20 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ard van Breemen <ard@kwaak.net>, linux-kernel@vger.kernel.org
Subject: Re: [BUG 2579] linux 2.6.* sound problems
References: <53L1x-6dC-13@gated-at.bofh.it> <53LkE-6QU-5@gated-at.bofh.it>	 <53LkW-6QU-49@gated-at.bofh.it> <53LEq-7gr-7@gated-at.bofh.it>	 <43667406.9070104@gmail.com> <4366A49F.3000101@rainbow-software.org>	 <43673B6F.5030909@gmail.com>  <20051123162216.GG1700@kwaak.net>	 <1132775178.10453.14.camel@mindpipe>  <4384CB8B.6040409@gmail.com> <1132777329.10453.21.camel@mindpipe>
In-Reply-To: <1132777329.10453.21.camel@mindpipe>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell ha scritto:

>On Wed, 2005-11-23 at 21:05 +0100, Patrizio Bassi wrote:
>  
>
>>it seems both.
>>now i'm using 1000hz with 0x40 latency.
>>i still get some noises but lower than before (lat = 0x20).
>>
>>however i saw you marked it closed as hardware problem, i'm sure it
>>isn't.
>>
>>it' a linux 2.6 problem for me, as 2.4 and windows works perfectly.
>>stop :)
>>a windows copy, running under vmware on linux 2.6, seems to work good
>>too.
>>
>>    
>>
>
>If the noise is caused by higher HZ settings then that is a hardware
>problem.  Windows and Linux 2.4 use a lower HZ setting than Linux 2.6.
>
>Lee
>
>
>  
>
i'm not sure of this, however i trust you as you'll have more experience
than me.

i'll buy no more creative cheap hw.
