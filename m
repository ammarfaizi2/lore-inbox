Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317415AbSGXRUp>; Wed, 24 Jul 2002 13:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317416AbSGXRUp>; Wed, 24 Jul 2002 13:20:45 -0400
Received: from syndetix.com ([204.134.124.201]:25577 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S317415AbSGXRUo>;
	Wed, 24 Jul 2002 13:20:44 -0400
Message-ID: <3D3EE4B1.3000809@zianet.com>
Date: Wed, 24 Jul 2002 11:32:33 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020723
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3com 3c996b-t support?
References: <Pine.LNX.4.33.0207241314550.30282-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is just that I was reading this page where they evaluate
gigi cards and they used the drivers from 3com.

http://www.cs.uni.edu/~gray/gig-over-copper/

The 3com drivers are open-source though, which makes
me less hesitent.  And the tigon3 drivers lack of documentation
kind of irks me.  I would however like to stick with a mainstream kernel
driver cause the support is there if it is needed.  I guess I will give
both versions a whirl.  From just glancing at the source of both, it seems
that both versions support jumbo frames which is really what I am after.

Steve

Mark Hahn wrote:

>>drivers out and found out which performs better?  Should I
>>stick with what 3com provides or go with what is in the kernel
>>if it works?
>>    
>>
>
>several good kernel hackers maintain, tune and polish the kernel versions.
>I wouldn't even consider the stuff from the vendor.
>
>
>
>  
>



