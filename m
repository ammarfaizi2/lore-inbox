Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUETVr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUETVr0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 17:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265184AbUETVr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 17:47:26 -0400
Received: from fate.eng.buffalo.edu ([128.205.25.5]:59104 "EHLO
	fate.eng.buffalo.edu") by vger.kernel.org with ESMTP
	id S265212AbUETVrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 17:47:19 -0400
Message-ID: <40AD28E0.2080705@eng.buffalo.edu>
Date: Thu, 20 May 2004 17:53:36 -0400
From: Gopikrishnan Sidhardhan <gs33@eng.buffalo.edu>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Data loss on IDE drive after crash
References: <40AD0365.6040003@eng.buffalo.edu> <1085081357.2044.1.camel@cassius.public.buffalo.edu> <20040520233312.B2172@electric-eye.fr.zoreil.com>
In-Reply-To: <20040520233312.B2172@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-Buffalo.EDU-Metrics: fate.eng.buffalo.edu 1029; Body=0 Fuz1=0 Fuz2=0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:

>Gopikrishnan Sidhardhan <gs33@eng.buffalo.edu> :
>[...]
>  
>
>>>At that point, I had my X configuration file open.  
>>>      
>>>
>>This is not quite true.  I had just written to it and closed it.  Sorry
>>for the confusion.
>>    
>>
>
>sync ?
>
>--
>Ueimor
>  
>
Is it?  The file has totally disppeared.  Isn't it because the inode has 
been marked as belonging to a deleted file?

Thanks,
--Gopi
