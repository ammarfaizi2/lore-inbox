Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268907AbUI2T7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268907AbUI2T7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 15:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268919AbUI2T7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 15:59:36 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:20205 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S268907AbUI2T73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 15:59:29 -0400
Message-ID: <415B0BFA.6050203@drdos.com>
Date: Wed, 29 Sep 2004 13:24:42 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@novell.com>,
       Ankit Jain <ankitjain1580@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: processor affinity
References: <20040928122517.9741.qmail@web52907.mail.yahoo.com> <41596F7F.1000905@drdos.com> <1096387088.4911.4.camel@betsy.boston.ximian.com> <41598B23.50702@drdos.com> <1096408318.13983.47.camel@localhost.localdomain> <415AE953.3070105@drdos.com> <20040929184510.A15692@infradead.org>
In-Reply-To: <20040929184510.A15692@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Wed, Sep 29, 2004 at 10:56:51AM -0600, Jeff V. Merkey wrote:
>  
>
>>Using them for Intel Cache affinity was new at the time.  Intel SMP 
>>hardware was not readily available at the time and was in
>>its infancy in 1993 when this was developed.  This implementation (like 
>>Linux) was specific to IA32 architecture systems. 
>>    
>>
>
>The Linux implementation works on about a dozen plattforms, or how
>many smp ports we have these days..
>
>
>  
>
In it's early beginnings, Linux was IA32 based. A pretty cool idea at 
the time. The patent took ten years to issue due to all the prior
art claims. I remember Novell's lawyers bringing me reams of prior art 
to review during the initial work to verify there was no prior
art in the field. Apparently, this was for first affinity patent on SMP 
architecture systems filed, or it would not have issued. Anyway, I 
provided it as a reference since it is the first patent on SMP affinity 
scheduling and methods for the very interested person who asked. And 
yes, Linux
appears to infringe it, but since Novell is pro-Linux, I don't think it 
matters.

:-)

Jeff
