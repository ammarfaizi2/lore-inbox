Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268739AbUI2RcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268739AbUI2RcI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268706AbUI2Rbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:31:48 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:34540 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S268739AbUI2RbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:31:03 -0400
Message-ID: <415AE953.3070105@drdos.com>
Date: Wed, 29 Sep 2004 10:56:51 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Love <rml@novell.com>, Ankit Jain <ankitjain1580@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: processor affinity
References: <20040928122517.9741.qmail@web52907.mail.yahoo.com>	 <41596F7F.1000905@drdos.com>	 <1096387088.4911.4.camel@betsy.boston.ximian.com>	 <41598B23.50702@drdos.com> <1096408318.13983.47.camel@localhost.localdomain>
In-Reply-To: <1096408318.13983.47.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Maw, 2004-09-28 at 17:02, Jeff V. Merkey wrote:
>  
>
>>>>http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=/netahtml/search-bool.html&r=2&f=G&l=50&co1=AND&d=ptxt&s1=merkey.INZZ.&OS=IN/merkey&RS=IN/merkey
>>>>        
>>>>
>>>Wow, I never knew about that.
>>>
>>>But guess who wrote the affinity system calls? :)
>>>      
>>>
>
>  
>
>>I wrote them first, and coined the term. 
>>    
>>
>
>Cute but GCOS3 had affinity syscalls for batch processing in the 1970's
>and I don't believe it was original even then.
>  
>

Using them for Intel Cache affinity was new at the time.  Intel SMP 
hardware was not readily available at the time and was in
its infancy in 1993 when this was developed.  This implementation (like 
Linux) was specific to IA32 architecture systems. 

Jeff

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

