Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVEYFSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVEYFSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 01:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVEYFS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 01:18:29 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:65370 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262273AbVEYFSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 01:18:01 -0400
Message-ID: <42940A87.7010504@yahoo.com.au>
Date: Wed, 25 May 2005 15:17:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <4292DFC3.3060108@yahoo.com.au> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <200505242326.16929.gene.heskett@verizon.net>
In-Reply-To: <200505242326.16929.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Tuesday 24 May 2005 22:20, Andrew Morton wrote:
>
>>Sven Dietrich <sdietrich@mvista.com> wrote:
>>
>>>I think people would find their system responsiveness / tunability
>>> goes up tremendously, if you drop just a few unimportant IRQs
>>>into threads.
>>>
>>People cannot detect the difference between 1000usec and 50usec
>>latencies, so they aren't going to notice any changes in
>>responsiveness at all.
>>
>
>Excuse me?
>

You are excused ;)

> 1 second (1000 usecs, 200 times your 50 usec example) is 
>

1000usecs is 1msec.

>VERY noticeable when you are listening to music, or worse yet, trying 
>to edit it.  For much of that, submillisecond accuracy makes or 
>breaks the application.
>
>

For listening to music, 1msec is absolutely no problem. For editing,
perhaps it is getting problematic. But Andrew (and parent) were
not talking about realtime applications, but *interactivity*.

>Lets get out of the server only camp here folks, linux is used for a 
>hell of a lot more than a home for apache.
>
Let's all try to keep calm and think carefully about what someone has said
and in what context before responding.

This is a topic that for some reason will tend to degenerate into a random
shouting match where nobody actually says anything or listens to anything,
and nothing gets done. Not to say you are trying to start a flamewar, Gene,
but everyone just needs to tread a bit carefully :)

Send instant messages to your online friends http://au.messenger.yahoo.com 
