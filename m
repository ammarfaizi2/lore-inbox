Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbULPDpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbULPDpG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 22:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbULPDpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 22:45:06 -0500
Received: from terminus.zytor.com ([209.128.68.124]:5079 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261917AbULPDpB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 22:45:01 -0500
Message-ID: <41C0F67D.4000506@zytor.com>
Date: Wed, 15 Dec 2004 18:44:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What if?
References: <41AE5BF8.3040100@gmail.com> <20041202044034.GA8602@thunk.org>	 <1101976424l.5095l.0l@werewolf.able.es>	 <1101984361.28965.10.camel@tara.firmix.at>	 <cpkc5i$84f$1@terminus.zytor.com>  <1102972125l.7475l.0l@werewolf.able.es> <1103158646.3585.35.camel@localhost.localdomain>
In-Reply-To: <1103158646.3585.35.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2004-12-13 at 21:08, J.A. Magallon wrote:
> 
>>>Type-safe linkage, mainly.  That actually would be a nice thing.
>>>
>>And let the compiler do all what now is done by hand wrt driver methods,
>>inheritance, specialized methods and so on, with a 1000% increase in security
>>because compiler does not forget to do thinks, like we do ;)
> 
> This is not a C++ thing per se however. A future gcc could do type safe
> linkage of C programs instead of C++.

Yes, but there is also no really big deal compiling C code with a C++ 
compiler.  Yes, it was a disaster in 0.99.14, but that was 10 years ago.

There is a huge difference between "C compiled with a C++ compiler" and 
the "go crazy with keeping the programmer in the dark" concept proposed 
by Mr. Magallon.

	-hpa
