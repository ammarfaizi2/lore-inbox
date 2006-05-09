Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWEIG5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWEIG5g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 02:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWEIG5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 02:57:36 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:14760 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751430AbWEIG5f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 02:57:35 -0400
Message-ID: <44603CA0.2050304@aitel.hist.no>
Date: Tue, 09 May 2006 08:54:24 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       Pavel Machek <pavel@ucw.cz>, dtor_core@ameritech.net,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: Remove silly messages from input layer.
References: <20060504024404.GA17818@redhat.com> <20060505152748.GA22870@redhat.com> <445EE899.6040908@aitel.hist.no> <200605081725.29977.kernel@kolivas.org>
In-Reply-To: <200605081725.29977.kernel@kolivas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>On Monday 08 May 2006 16:43, Helge Hafting wrote:
>  
>
>>Dave Jones wrote:
>>    
>>
>>>On Fri, May 05, 2006 at 12:31:23PM +0200, Pavel Machek wrote:
>>>      
>>>
>>>>If you only pressed single key -- your keyboard is crap or there's
>>>>some problem in the driver.
>>>>
>>>>If you never pressed any key -- your keyboard is crap or there's
>>>>some problem in the driver.
>>>>        
>>>>
>>>That's hardly a constructive answer when the keyboard is a part of
>>>a laptop.  Crap hardware exists, get used to it.
>>>      
>>>
>>If some laptop comes with a bad keyboard, please blacklist
>>it so future linux users can avoid the brand when shopping
>>for hardware.
>>    
>>
>
>This is great in theory but if we end up blacklisting half of the hardware out 
>there we're stuffed. The truth is most hardware out there is cheap and nasty 
>and sells in vast quantities. We have workarounds for timer code being buggy 
>on virtually half the motherboards out there on amd64 for example...
>  
>
Well, it depends on how broken they are then.
These keyboards actually work, so it is not so much a case
of being broken, more a case of  "too cheap to follow the spec,
but we can still get the keypresses"? 

I should have been more clear.  With blacklisting, I didn't mean
to make the driver refuse them.  I was thinking about
http://www.tldp.org/HOWTO/Hardware-HOWTO/index.html
and similiar sites, where a buyer can go and look for any linux issues
with the hardware he plans to buy.  There is no problem if 50%
of all hardware ends up here - one can then read about the issues
and decide if they matter enough to get a different brand instead.

Helge Hafting
