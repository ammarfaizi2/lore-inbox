Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVIJIlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVIJIlI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 04:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVIJIlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 04:41:08 -0400
Received: from smtpout.mac.com ([17.250.248.88]:10719 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750704AbVIJIlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 04:41:06 -0400
In-Reply-To: <9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050903064124.GA31400@codepoet.org> <4319BEF5.2070000@zytor.com> <B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com> <dfhs4u$1ld$1@terminus.zytor.com> <5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com> <9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined by GCC from 2.95 to current CVS)
Date: Sat, 10 Sep 2005 04:40:33 -0400
To: LKML Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 5, 2005, at 21:29:27, Kyle Moffett wrote:
> On Sep 5, 2005, at 19:28:07, Kyle Moffett wrote:
>
>> With all of that mess out of the way, I'll work on getting a few  
>> initial RFC
>> patches out the door, and then we can revisit this discussion once  
>> there is
>> something tangible to talk about.
>
> If this is generally acceptable, I'll break it up into small  
> digestible
> pieces and send to individual maintainers...

Ok, here's the broken-out version.  I haven't yet found a good  
patchbomb script,
so until I do, I've got the broken-out parts on the web here:

http://zeus.moffetthome.net/~kyle/patches/convert-assembly-to-assembler/

The file 000-convert-assembly-to-assembler.diffstat in that directory  
has the
diffstat.

And once again, my 650MB upload limit applies, although so far I  
haven't even
come close, so it's not that big an issue, really...

PS:  If you have a nice patchbomb script with support for CC-ing  
individual
maintainers, numerical patch numbers, etc that you're willing to send  
me, I
would appreciate it a lot!

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at
people who weren't supposed to be in your machine room.
   -- Anthony de Boer


