Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTIXWhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 18:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbTIXWhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 18:37:08 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:10259 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S261555AbTIXWhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 18:37:02 -0400
Message-ID: <3F721D2B.7070703@techsource.com>
Date: Wed, 24 Sep 2003 18:39:39 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Minimizing the Kernel
References: <200309241732.h8OHWj05015957@green.mif.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrzej Krzysztofowicz wrote:
>>>Well for starters dont use gcc 3 or above.. code size has increased
>>>dramatically with thoose versions. sure they give you more optimization
>>
>>Hmm, has anyone tried -Os with gcc3+ ?
>>Maybe that'd be good for size optimization?
> 
> 
> AFAIK, the -Os optimization in gcc3 gives you larger binary than -Os in
> gcc2.
> 

Any ideas why?  I mean, what does all the extra code DO?

And have you considered that some of that extra code might be there for 
correctness purposes?

