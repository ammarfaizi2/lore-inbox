Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbVIOCNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbVIOCNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 22:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVIOCNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 22:13:48 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:29692 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1030340AbVIOCNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 22:13:46 -0400
From: Daniel Goller <morfic@gentoo.org>
To: ncunningham@cyclades.com
Subject: Re: [linux-pm] swsusp3: push image reading/writing into userspace
Date: Wed, 14 Sep 2005 21:13:02 -0500
User-Agent: KMail/1.8.2
References: <20050914223206.GA2376@elf.ucw.cz> <1126749596.3987.5.camel@localhost>
In-Reply-To: <1126749596.3987.5.camel@localhost>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509142113.03763.morfic@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 September 2005 08:59 pm, Nigel Cunningham wrote:
> Hi Pavel.
>
> On Thu, 2005-09-15 at 08:32, Pavel Machek wrote:
> > Hi!
> >
> > Here's prototype code for swsusp3. It seems to work for me, but don't
> > try it... yet. Code is very ugly at places, sorry, I know and will fix
> > it. This is just proof that it can be done, and that it can be done
> > without excessive ammount of code.
>
> No comments on the code sorry. Instead I want to ask, could you please
> find a different name? swsusp3 is going to make people think that it's
> Suspend2 redesigned. Since there hasn't been a swsusp2 (so far as I
> know), 

swsusp2 seems to be the common/trivial name for suspend2 (at least while 
struggling to get any kind of suspend working here, helpful people have 
refered to suspend2 as swsusp2)

> how about using that name instead? At least then we'll clearly 
> differentiate the two implementations and you won't confuse/irritate
> users.

if he would use that people would get quite confused and not know if people 
mean your suspend2 or his swsusp2

Just a thought,

Daniel
