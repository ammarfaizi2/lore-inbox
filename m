Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbVFXRDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbVFXRDg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 13:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbVFXRDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 13:03:36 -0400
Received: from [67.137.28.189] ([67.137.28.189]:20114 "EHLO vger")
	by vger.kernel.org with ESMTP id S263164AbVFXRAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 13:00:00 -0400
Message-ID: <42BC2CFB.2010105@utah-nac.org>
Date: Fri, 24 Jun 2005 09:55:39 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
Cc: Jan Beulich <JBeulich@novell.com>,
       Christoph Lameter <christoph@lameter.com>,
       Clyde Griffin <CGRIFFIN@novell.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Novell Linux Kernel Debugger (NLKD)
References: <s2bae938.075@sinclair.provo.novell.com> <42BBC297020000780001D4A5@emea1-mh.id2.novell.com> <42BB932D.9050808@utah-nac.org> <200506240750.03736.mason@suse.com>
In-Reply-To: <200506240750.03736.mason@suse.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>On Friday 24 June 2005 00:59, jmerkey wrote:
>  
>
>>Jan Beulich wrote:
>>    
>>
>>>>It's a GBD replacement and is not fully open source.
>>>>        
>>>>
>>>What is not open source in it ()?
>>>
>>>      
>>>
>>>>KDB is at present more capable. It has a lot of promise, but it does not
>>>>have the all the architectural
>>>>features necessary to replace either KDB or GDB at present.
>>>>        
>>>>
>>>While I never used or saw kdb, I'd be curious about what you immediately
>>>saw missing...
>>>      
>>>
>>1. No back trace
>>2. Doesn't run standalone fully embeded in the kernel
>>3. Not fully open source (since it's not embeded in the kernel)
>>4. IA64 doesn't really matter, since IA64 is basically dead anyway
>>5. No advanced recursive descent parser for conditional breakpoints
>>    
>>
>
>This is more or less completely inaccurate.
>
>  
>

Which one -- more ?  or less ? 

Jeff

>-chris
>
>
>
>  
>

