Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267005AbTAKBSN>; Fri, 10 Jan 2003 20:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267007AbTAKBSN>; Fri, 10 Jan 2003 20:18:13 -0500
Received: from freeside.toyota.com ([63.87.74.7]:61073 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S267005AbTAKBSL>; Fri, 10 Jan 2003 20:18:11 -0500
Message-ID: <3E1F72D7.7050505@lexus.com>
Date: Fri, 10 Jan 2003 17:26:47 -0800
From: jjs <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@gmx.net>
CC: Bill Abt <babt@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: NGPT 2.2.0 RELEASED: TOPS LINUXTHREADS AND NPTL IN SCALABILITY
 AND PERFORMANCE
References: <OFD6D876A7.7D7E3A46-ON85256CAA.0068C7D5@us.ibm.com> <200301110203.09346.m.c.p@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:

>On Friday 10 January 2003 20:58, Bill Abt wrote:
>
>Hi Bill,
>
>  
>
>>In this release, the primary focus was performance.  Significant
>>performance and scalability enhance-
>>ments have been made to this release making it the fastest and most
>>scalable POSIX compliant
>>threads package available on the Linux platform.
>>    
>>
>hmm, can this be true?
>
The benchmarks are likely an accurate, good faith
measurement of the stated systems, and ngpt is
obviously an improvement over the old linuxthreads -

But according to my understanding, a more accurate
measure of nptl performance would require a current
glibc, with the nptl-specific enhancements -

or am I missing something here?

Joe


