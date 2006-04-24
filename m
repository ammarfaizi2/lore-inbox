Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWDXUtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWDXUtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWDXUtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:49:20 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:39819 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751232AbWDXUtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:49:19 -0400
Message-ID: <444D44F2.8090300@wolfmountaingroup.com>
Date: Mon, 24 Apr 2006 15:36:50 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: Gary Poppitz <poppitzg@iomega.com>, linux-kernel@vger.kernel.org
Subject: Re: C++ pushback
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com> <mj+md-20060424.201044.18351.atrey@ucw.cz>
In-Reply-To: <mj+md-20060424.201044.18351.atrey@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:

>>If there is a childish temper tantrum mentality about C++ then I have  
>>no reason or desire to be on this list.
>>    
>>
>
>Can you name any reasons for why should we support C++ in the kernel?
>Why shouldn't we invest the effort to making it possible to write kernel
>modules in Haskell instead?
>
>The kernel is written in C and its maintainers have so far agreed that
>C is enough and adding any other language brings more pain than gain.
>
>If you think otherwise, feel free to submit some real code which shows
>the advantages of using a different language.
>
>				Have a nice fortnight
>  
>
C++ in the kernel is a BAD IDEA. C++ code can be written in such a 
convoluted manner as to be unmaintainable and unreadable.
All of the hidden memory allocations from constructor/destructor 
operatings can and do KILL OS PERFORMANCE. Java
is a great example as to why kernel OS code should NEVER be allowed in C++.

C and C++ really show their origins when used in kernel level 
programming. So what were C and C++ originally -- they were grades. :-)

I applaud the LKML folks pushing back on C++.

A++.

Jeff



