Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271828AbRICVW2>; Mon, 3 Sep 2001 17:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271831AbRICVWS>; Mon, 3 Sep 2001 17:22:18 -0400
Received: from james.kalifornia.com ([208.179.59.2]:17016 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S271828AbRICVWE>; Mon, 3 Sep 2001 17:22:04 -0400
Message-ID: <3B93F3D4.8020508@kalifornia.com>
Date: Mon, 03 Sep 2001 14:19:16 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010829
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Editing-in-place of a large file
In-Reply-To: <E15drHT-0001TX-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>That is reimplementing file system functionality in user space. 
>>I'm in doubts that this is considered good design...
>>
>
>Keeping things out of the kernel is good design. Your block indirections
>are no different to other database formats. Perhaps you think we should
>have fsql_operation() and libdb in kernel 8)
>

 From what I've read, that is where windows is going!

-b

-- 
Number of restrictions placed on "Alice in Wonderland" (public domain)    
eBook:  5

Maximum penalty for reading "Alice in Wonderland" aloud (possible DMCA    
violation):  5 years jail

Average sentence for commiting Rape: 5 years



