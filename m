Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263011AbVGNLF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbVGNLF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 07:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbVGNLF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 07:05:28 -0400
Received: from BTNL-TN-DSL-static-006.0.144.59.touchtelindia.net ([59.144.0.6]:21377
	"EHLO mail.prodmail.net") by vger.kernel.org with ESMTP
	id S263011AbVGNLFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 07:05:17 -0400
Message-ID: <42D6462B.8030706@prodmail.net>
Date: Thu, 14 Jul 2005 16:32:03 +0530
From: RVK <rvk@prodmail.net>
Reply-To: rvk@prodmail.net
Organization: GSEC1
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Campbell <ijc@hellion.org.uk>
CC: Arjan van de Ven <arjan@infradead.org>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Thread_Id
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it>	 <42CB465E.6080104@shaw.ca>  <42D5F934.6000603@prodmail.net>	 <1121327103.3967.14.camel@laptopd505.fenrus.org>	 <42D63916.7000007@prodmail.net> <1121337567.18265.26.camel@icampbell-debian>
In-Reply-To: <1121337567.18265.26.camel@icampbell-debian>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Campbell wrote:

>On Thu, 2005-07-14 at 15:36 +0530, RVK wrote:
>
>  
>
>>bits/pthreadtypes.h:150:typedef unsigned long int pthread_t;
>>    
>>
>
>That's an implementation detail which you cannot determine any
>information from.
>
>What Arjan is saying is that pthread_t is a cookie -- this means that
>you cannot interpret it in any way, it is just a "thing" which you can
>pass back to the API, that pthread_t happens to be typedef'd to unsigned
>long int is irrelevant.
>
>  
>
Do you want to say for both 2.6.x and 2.4.x I should interpret that way ?

rvk

>Ian.
>
>--
>Ian Campbell
>Current Noise: Nile - Annihilation Of The Wicked
>
>Don't tell me what you dreamed last night for I've been reading Freud.
>.
>
>  
>

