Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266472AbUFVEyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266472AbUFVEyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 00:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbUFVEyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 00:54:40 -0400
Received: from opersys.com ([64.40.108.71]:1292 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S266472AbUFVEyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 00:54:37 -0400
Message-ID: <40D7BA92.5010201@opersys.com>
Date: Tue, 22 Jun 2004 00:50:26 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: ganzinger@mvista.com
CC: Geoff Levand <geoffrey.levand@am.sony.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Philippe Gerum <rpm@xenomai.org>
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
References: <40C7BE29.9010600@am.sony.com> <40CA4D23.2010006@opersys.com> <40CE1128.8030806@mvista.com> <40D6529F.6060305@opersys.com> <40D7542B.3020508@mvista.com>
In-Reply-To: <40D7542B.3020508@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


George Anzinger wrote:
> I think the real problem is an open source question.  The RTAI and 
> RTLINUX folks are not exactly in the same camp (either with each other 
> OR with LINUX) in this regard.  Should that change and one or more of 
> these become truly open source without others claiming "foul", there are 
> vendors who are ready and willing to work with the code.  Vendors of 
> open source (and their customers) don't want to find themselves in law 
> suits...

There's no other way to call it: This is just plain ignorance.

If you care to actually look at the record, you will see that RTAI has
always been and will always been "open source". I'm not going to qualify
other peoples' claims against it, but let me just say that you've
succumbed to FUD, ant THAT is totally pathetic.

I personally don't see why Linux's future should be dictated by a bunch
of worried PHBs who haven't even cared to research the case. Following
you logic, maybe we should just all stop using Linux altogether just in
case SCO sues.

> As such, this is really off topic...  as is a discussion of the merits 
> of this sort of solution.  On this list we are interested in working in 
> the confines of LINUX as found on linux.org possibly modified by truly 
> open source patches and packages.

Again, you don't know what you're talking about. If you have any actual,
factual and timely claim against RTAI, then please voice it now.
Otherwise, this is plain misleading. Not to mention that offloading
something so foreign as hard-rt into a module is actually not that
unlike Linux as many vendors, including your employer, claim it to be.

Note that my entire point was about how Adeos could be used as an engine
for providing much more than HRT could ever provide. Adeos has always
been independent from RTAI and is based entirely on scientific publications
that predate the patent. As has been proven on this list, any claim that
it is somehow covered by the patent is patently absurd. So whether you
buy the FUD against RTAI or not is really inconsequential. The real issue
is what Adeos can provide that HRT and all the other wannabee solutions
just can't provide.

If FUD is what is driving you to get HRT into Linux, it would just go to
show that you have a very poor understanding of what Linux is about.

I take it, though, that since you haven't actually countered my argument,
you actually agree with me that RTAI/fusion on Adeos is a far superior
solution to HRT on technical terms. Given that you've agreed with that,
I'd encourage you now to actually read up on the topic of RTAI and
open source so that you too can join in working on RTAI/fusion, and stop
the time-waste that HRT is.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

