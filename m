Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266037AbTIJXgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 19:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266040AbTIJXgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 19:36:14 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:17029 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S266037AbTIJXgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 19:36:05 -0400
From: James Clark <jimwclark@ntlworld.com>
Reply-To: jimwclark@ntlworld.com
To: Timothy Miller <miller@techsource.com>,
       David Schwartz <davids@webmaster.com>
Subject: Re: People, not GPL  [was: Re: Driver Model]
Date: Thu, 11 Sep 2003 00:35:10 +0100
User-Agent: KMail/1.5
Cc: Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
References: <MDEHLPKNGKAHNMBLJOLKEEOCGDAA.davids@webmaster.com> <3F5F3C46.4060004@techsource.com>
In-Reply-To: <3F5F3C46.4060004@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309110035.10611.jimwclark@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In many ways the original intention of the debate was lost in the battle. 
There are a lot of zealots on both sides of the GPL debate - personally, my 
undertanding is that the GPL forbids usage restrictions, thus once you 
release code under the GPL you cannot control it. This seems especially 
important in a project, such as Linux, that has been collaboratively 
developmed by a whole community.

The original question was would a binary driver interface allow easier usage 
by 'normal' users with any compatible kernel (rather than specific versions) 
and perhaps simplify module development cycle? 

Would the performance hit involved be worth the potential 
compatibility/simplicity? 

A lot of people have, assumed that this is a call to arms for binary-only 
modules. This is not true although this type of change would make such things 
more common.

James


On Wednesday 10 Sep 2003 3:59 pm, Timothy Miller wrote:
> I'm still 1600 messages behind in reading the list, but I have spent
> enough time reading the discussion about GPL and drivers that I feel
> compelled to comment.  I don't intend to comment further because I don't
> want to contribute to a flamewar any more than this already will.  But I
> feel the need to defend those who contribute to Free Software against
> those who don't.
>
> The argument I have been reading has been centered around the idea of
> working around the GPL to support binary-only driver and various other
> things which are counter to the spirit of the GPL and Linux.  But
> someone who is trying to find a legal GPL loophole is not considering
> the root of the situation and that the GPL is an effect, not a cause.
>
> A point someone else made that I feel compelled to reiterate is that it
> is the nature of the Linux development model and the attitude of the
> developers which has made Linux what it is and has made you want to use it.
>
> But I have another point.  You are not dealing with a license here.  The
> license is there to satisfy lawyers and make clear the INTENT of the
> authors.  The keyword here is INTENT in that someone who has developed
> something is telling you how they feel about the use of their work
> which, under many circumstances, they could have chosen not to share
> with you.  What you are dealing with is real people who have put an
> incredible amount of time and effort into developing Linux.  Those
> people, to whom you owe much respect for sharing their contributions,
> have decided that their software should be used with certain
> restrictions, that being the GPL.  If you abuse Linux, it is not the GPL
> that you are insulting, but the people who developed Linux.
>
> The GPL_ONLY restriction for driver modules may seem unfair, but it is
> far from it.  There are both valid technical and philosophical reasons
> for working that way.  No one forces you to use Linux, and when you made
> the choice to use it, you are entering into a community with a specific
> philosophy.  You know that philosophy in advance, so when you discover
> that you have a restruction you don't like, you have no room to complain.
>
> As someone said, if you want to write drivers for a UNIX which does not
> have these restrictions, there are plenty of commercial UNIXes out there
> that you have to choose from.  The fact that they are perhaps less
> popular is one reason why Linux developers do not want to imitate them.
>
> So, the discussions about finding ways to make a non-GPL driver look
> like a GPL driver and get away with it legally are all moot.  The reason
> you should not violate this is because the architects of Linux do not
> want you to.  If you choose to violate that, you are being unethical,
> pure and simple.  Or more to the point, you're being an asshole to a lot
> of hard-working people who have chosen to freely share their work with
> you.  Since they are the authors and you are not, their feelings about
> their softare are more important than yours.  You may be able to screw
> them over and get away with it -- people do that sort of thing all the
> time -- but the fact that you may find a legal loophole doesn't make you
> any less of an abject asshole.
>
> In short:  Be honorable.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

