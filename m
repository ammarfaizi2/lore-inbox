Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSL2XL5>; Sun, 29 Dec 2002 18:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSL2XL5>; Sun, 29 Dec 2002 18:11:57 -0500
Received: from falcon.vispa.uk.net ([62.24.228.11]:6666 "EHLO falcon.vispa.com")
	by vger.kernel.org with ESMTP id <S262201AbSL2XL4>;
	Sun, 29 Dec 2002 18:11:56 -0500
Message-ID: <3E0F830F.9040203@walrond.org>
Date: Sun, 29 Dec 2002 23:19:43 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make i2c use initcalls everywhere
References: <20021229220436.A11420@lst.de> <20021229222628.GC2259@werewolf.able.es> <20021229223722.A10670@infradead.org> <20021229225350.GE2259@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Agreed. I would love to see the i2c and lmsensor stuff properly 
maintained in the kernel tree; It would save a whole lot of dicking around.

Pretty please?  ;)

J.A. Magallon wrote:
> On 2002.12.29 Christoph Hellwig wrote:
> 
>>On Sun, Dec 29, 2002 at 11:26:28PM +0100, J.A. Magallon wrote:
>>
>>>Wil this reach the i2c maintainer or the next auto-generated patch from i2c
>>>2.8.x will undo what you do now and will be sized 4Gb  ?
>>
>>There is no maintainer for drivers/i2c/.  The only updates it every got
>>was me syncinc with their releases and backing out obvious braindamage.
>>
>>
>>>Will this be accepted if I submit it, even independently of the maintainer ?
>>>Because I suppose (???) that maintainer is sending changes and they are going
>>>to trash...
>>
>>Maybe the changes the maintainers of the external i2c code are sending
>>_are_ trash?
>>
> 
> 
> (just put on the flame war suit...)
> 
> Stupid question: why people on http://secure.netroedge.com/~lm78/ is not
> smashed with a hammer on the head and 'morally forced' to post, comment, etc.
> patches on LKML ? They continue to ship releases, every vendor tracks them,
> and every vendor has to correct changes they have not tracked from mainline,
> like that old about __exit functions, and now initcalls...
> 
> I really do not understand some things about Linux. Some people look like
> living in alternative universes...
> 


