Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275118AbTHGGoq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 02:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275124AbTHGGoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 02:44:46 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:5105 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S275118AbTHGGon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 02:44:43 -0400
Message-ID: <3F31F558.5050104@linuxfreak.ca>
Date: Thu, 07 Aug 2003 02:44:40 -0400
From: Patrick McLean <pmclean@linuxfreak.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030731
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Is it possible to add this feature.
References: <3F3049D0.6040804@hsdm.com> <20030806003054.GN6541@kurtwerks.com> <20030806005348.GB15764@matchmail.com> <pan.2003.08.06.07.47.15.831811@sourcefrog.net>
In-Reply-To: <pan.2003.08.06.07.47.15.831811@sourcefrog.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Pool wrote:

>On Tue, 05 Aug 2003 17:53:48 -0700, Mike Fedyk wrote:
>
>  
>
>>On Tue, Aug 05, 2003 at 08:30:54PM -0400, Kurt Wall wrote:
>>    
>>
>>>Quoth hsdm:
>>>      
>>>
>>>>Is it posible to limit the amount of memory or CPU time per user?
>>>>        
>>>>
>>Basically, no.
>>
>>    
>>
>>>ulimit -m
>>>ulimit -t
>>>      
>>>
>>This is per session, and the user can have many sessions.  Unless you
>>limit the number of sessions a user can have...
>>    
>>
>
>Mike is correct that you cannot have system-wide per-user limits at the
>moment, at least in the standard kernel.  However, it would be possible to
>add it, if you find somebody to develop it for you.
>  
>
I am going to be working on this feature with a friend starting in
September as a term project (we are both undergrads in computer
science), and a way to get into kernel hacking :) Send me a mail if
you want more info, or if you want us to keep you up to date on
our progress.

We will also be loking for ways to specify the limits in a fairly 
simple, but scalable way, and we will be happy for any suggestions.


