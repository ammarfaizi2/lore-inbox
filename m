Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVCDE0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVCDE0X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 23:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVCCTmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:42:23 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:56770 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262518AbVCCTVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:21:12 -0500
Message-ID: <42276399.40709@dgreaves.com>
Date: Thu, 03 Mar 2005 19:20:57 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering - an orthogonal solution
References: <200503031644.j23Gi0Eh011165@laptop11.inf.utfsm.cl> <Pine.LNX.4.58.0503030855460.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503030855460.25732@ppc970.osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Thu, 3 Mar 2005, Horst von Brand wrote:
>  
>
>>[I'm pulling bk daily, and have it mixed with the ipw tree too, so I'm just
>> the kind of tester you are looking for... haven't seen any of the
>> showstopper bugs everybody is talking about, or I'd have screamed.]
>>    
>>
>
>Yeah, I wish everybody was like that. Sadly, it seems to be pretty rare to
>have people do weekly builds, much less daily. Daily builds is the holy
>grail for me, if just a small percentage of people did that, we'd be
>really well off.. Right not it's not even a "percentage", it's a very much
>self-selected small group of people, usually with what ends up actually
>being fairly similar high-end PC hardware.
>
>Now, I haven't actually gotten any complaints about 2.6.11 (apart from 
>"gcc4 still has problems" with fairly trivial solutions), so maybe the 
>whole cycle really worked out well this time, and I happened to choose a 
>really bad time to bring up this discussion. Or maybe this discussion 
>scared away people, and I just need to give it another week or two ;)
>
>		Linus
>  
>
I suspect you don't mean 'everybody'.
So who do you mean?

Why isn't there some advice on www.kernel.org that says:

  Do you use the Linux kernel?
  _You_ can make it better!!
  Here's how you can help...

and goes on to tell people how, depending on their familiarity and 
risk-aversion/linux-love ratio, they can install -mm kernels or -ck ones 
or -rc ones or -pre ones...

and it explains clearly what the intent and promises around each one are

and it explains the risks (probably in terms of likelihood of losing 
their digital photos!)

and it tells them how to subscribe to linux-kernel-announce

So they don't have to monitor lkml to know about them.


Maybe people like Horst could publicise the way in which they 
automatically download and deploy kernels.
I certainly wouldn't mind rebooting my desktop once a week to try a 
current kernel.

David
