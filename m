Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264148AbTIIOuX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 10:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTIIOuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 10:50:23 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:16654 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S264148AbTIIOuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 10:50:16 -0400
Message-ID: <3F5DEDBD.5090808@techsource.com>
Date: Tue, 09 Sep 2003 11:11:57 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: Mike Fedyk <mfedyk@matchmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Use of AI for process scheduling
References: <200309090119.h891JS307266@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rick Lindsley wrote:
>     Yeah, I didn't think his comment was very helpful since I thought it was 
>     clear that I was working on a draft of an IDEA.
> 
> How complex is your thinking where *ideas* need drafts? :)

It wasn't so much complex as it was _vague_.  :)

[snip]
> However, once we characterize "what we want" we might be able to
> communicate it (and code it) to the kernel.  To that end, here's an
> update on scheduler statistics code.  In testing, it's proved fairly
> non-intrusive and may provide some answers to "what we want".  If it
> doesn't, it's fairly extensible if done carefully.
> 
>     http://eaglet.rain.com/rick/linux/schedstat/
> 
> This patch (against 2.6.0-test4 or 2.6.0-test5) collects data about
> scheduler decisions, which may allow us, with 20/20 hindsight, to
> determine which specific decisions we don't like and perhaps how to
> modify them.


Now, THIS is the kind of thing I wanted to see!  Very cool.  My thought 
then is that it might be helpful to have some tools to help analyze this 
  raw data.  I'm sure you thought of that already.  :)

