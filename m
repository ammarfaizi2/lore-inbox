Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVAMDHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVAMDHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVAMDHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:07:19 -0500
Received: from l247169.ppp.asahi-net.or.jp ([218.219.247.169]:18659 "EHLO
	web2.davelinux.com") by vger.kernel.org with ESMTP id S261419AbVAMDHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:07:08 -0500
Message-ID: <39898.210.175.245.132.1105585516.squirrel@www.davelinux.com>
In-Reply-To: <Pine.LNX.4.58.0501121847410.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net><Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
    <20050112185133.GA10687@kroah.com><Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
    <20050112161227.GF32024@logos.cnet><Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
    <20050112205350.GM24518@redhat.com><Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
    <20050112182838.2aa7eec2.akpm@osdl.org>
    <Pine.LNX.4.58.0501121847410.2310@ppc970.osdl.org>
Date: Thu, 13 Jan 2005 12:05:16 +0900 (JST)
Subject: Re: thoughts on kernel security issues
From: "David Blomberg" <dblomber@davelinux.com>
To: linux-kernel@vger.kernel.org
Reply-To: dblomber@davelinux.com
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds said:
>
>
> On Wed, 12 Jan 2005, Andrew Morton wrote:
>>
>> That sounds a bit over-the-top to me, sorry.
>
> Maybe a bit pointed, but the question is: would a user perhaps want to
> know about a security fix a month earlier (knowing that bad people might
> guess at it too), or want the security fix a month later (knowing that the
> bad guys may well have known about the problem all the time _anyway_)?
>
> Being public is different from being known about. If vendor-sec knows
> about it, I don't find it at all unbelievable that some spam-virus writer
> might know about it too.
>
>>  All of these are of exactly the same severity as the rlimit bug,
>> and nobody cares, nobody is hurt.
>
> The fact is, 99% of the time, nobody really does care.
>
>> The fuss over the rlimit problem occurred simply because some external
>> organisation chose to make a fuss over it.
>
> I agree. And if i thad been out in the open all the time, the fuss simply
> would not have been there.
>
> I'm a big believer in _total_ openness. Accept the fact that bugs will
> happen. Be open about them, and fix them as soon as possible. None of this
> cloak-and-dagger stuff.
>
> 		Linus
>
Devils-advocate:  Who is on the vendor-sec list?  as I have started
devloping a roll your own linux dsitro (as 100s of other have as well) who
decides who is "approved" to hear about the fixes beforehand-what makes
SuSE, and Red Hat more deserving than Bonzai) User Base?
inhouse-developrs?.  I agree with Linus-san openness is best all around.
the rest is mostly politics.

-- 
David Blomberg
dblomber@davelinux.com
AIS, APS, ASE, CCNA, Linux+, LCA, LCP, LPI I, MCP, MCSA, MCSE, RHCE, Server+

