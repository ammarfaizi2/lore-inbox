Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262844AbTDAUOl>; Tue, 1 Apr 2003 15:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262840AbTDAUNo>; Tue, 1 Apr 2003 15:13:44 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:56582
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S262839AbTDAUNj>; Tue, 1 Apr 2003 15:13:39 -0500
Message-ID: <3E89F52F.3090802@rackable.com>
Date: Tue, 01 Apr 2003 12:23:11 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "martin.knoblauch " <"martin.knoblauch "@mscsoftware.com>
CC: gibbs@scsiguy.com, linux-kernel@vger.kernel.org
Subject: Re: File system corruption under 2.4.21-pre5-ac1
References: <3E8951D0.5327C7FE@mscsoftware.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Apr 2003 20:24:58.0160 (UTC) FILETIME=[C3A9F300:01C2F88C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch wrote:

>>Re: File system corruption under 2.4.21-pre5-ac1
>>
>>From: Justin T. Gibbs (gibbs@scsiguy.com)
>>Date: Mon Mar 31 2003 - 14:26:27 EST
>>
>>
>>    
>>
>>>I'm seeing filesystem corruption on a number of intel SE7501wv2's under
>>>2.4.21-pre5-ac1. The systems are running Cerberus (ctcs). They fail the
>>>kcompile, and memtst tests.
>>>      
>>>
>>Are you running the aic79xx driver version embedded in that kernel version
>>or the latest from my site?
>>
>>http://people.FreeBSD.org/~gibbs/linux/SRC/
>>
>>    
>>
>Justin,
>
> would you call the 1.3.6 version of aic79xx stable or "production
>quality"? There still seems to be quite a lot of changes going on. 
>
>  
>

   Up until this point I've found the aic79xx driver to be very stable. 
 I know people running 100s of systems without issue on older revs of 
the driver.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



