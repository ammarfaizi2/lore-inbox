Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261487AbTCJWUQ>; Mon, 10 Mar 2003 17:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261503AbTCJWUQ>; Mon, 10 Mar 2003 17:20:16 -0500
Received: from ns.splentec.com ([209.47.35.194]:7432 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S261487AbTCJWUP>;
	Mon, 10 Mar 2003 17:20:15 -0500
Message-ID: <3E6D120A.6040207@splentec.com>
Date: Mon, 10 Mar 2003 17:30:34 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tommy Reynolds <reynolds@redhat.com>
CC: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coding style addendum
References: <Pine.LNX.3.95.1030310162308.14367A-100000@chaos>	<3E6D096A.1080006@splentec.com> <20030310160743.76ed3d67.reynolds@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tommy Reynolds wrote:
>> References:
>> [1] ``The Elements of Programming Style'' by Kernighan
>> and Plauger, 2nd ed, 1988, McGraw-Hill.
> 
> 
> Keep in  mind the date here.   Prior to this time,  subroutines were the

Yes, I'm aware of the date.  AFAIR, 1 ed. is circa 1974, so in 14 years
I'd say the principles were still effective.

``Prior to this time'' you probably meant prior to 1974.

[cut]
> functional  abstractions.  Using  your  argument that  the example  code
> hides an "implementation", it's difficult  to conceive of a code example
> that hids neither its data nor its implementation.

So why should you change a definition to allow for a specific case?
Isn't a function de facto an implementation detail and thus encapsulating
the actual implementation (i.e. it's workings).
Anyway this is not important and is just formalisms.

My whole point was to put down in text file, the already practiced rule
of thinking out data representations, since this has direct effect on
the complexity of the code (i.e. the choice of data represenation).

I'm sure you know which example I'm thinking of.

-- 
Luben


