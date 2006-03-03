Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWCCPW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWCCPW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWCCPW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:22:57 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:11740 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S932084AbWCCPW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:22:56 -0500
Message-ID: <44085F31.6040705@metro.cx>
Date: Fri, 03 Mar 2006 16:22:25 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/14] s3c2412/s3c2413 support
References: <44082001.9090308@metro.cx> <20060303151023.GB2580@ucw.cz>
In-Reply-To: <20060303151023.GB2580@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>On Fri 03-03-06 11:52:49, Koen Martens wrote:
>  
>
>>This patchset adds various defines and bits for the 
>>s3c2412 and s3c2413
>>processors, as well as adding detection of this cpu to 
>>platform setup and
>>uncompress boot stage.
>>The changes should not disturb current s3c24xx 
>>implementations. The
>>patchset is preliminary, in that the final datasheet is 
>>not yet available. We
>>did some testing of these new registers and bits outside 
>>of the linux
>>kernel.
>>    
>>
>
>Ahha, it is actually arm derivative. Still it would be nice to have
>better name.
>  
>
Well, we could ask samsung to rename their range, but i doubt they will 
do so. Actually, there are a lot of these platforms already defined, eg 
s3c2410, s3c2440, s3c2400, etc..

But now that you mention it, i could have been more clear about this, 
stating that it was a Samsung ARM processor. Sorry about that, i don't 
think the issue is worth reposting the entire patchset or am i mistaken?

Best,

Koen

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/

