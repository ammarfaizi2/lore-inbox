Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbRFGTBn>; Thu, 7 Jun 2001 15:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262873AbRFGTBd>; Thu, 7 Jun 2001 15:01:33 -0400
Received: from snowbird.megapath.net ([216.200.176.7]:41996 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S262868AbRFGTBW>;
	Thu, 7 Jun 2001 15:01:22 -0400
Subject: Re: Break 2.4 VM in five easy steps
From: Miles Lane <miles@megapathdsl.net>
To: Derek Glidden <dglidden@illusionary.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B1FA29B.812AA63A@illusionary.com>
In-Reply-To: <Pine.LNX.4.33.0106062032390.26171-100000@asdf.capslock.lan>
	<991883613.15447.0.camel@agate>  <3B1FA29B.812AA63A@illusionary.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10 (Preview Release)
Date: 07 Jun 2001 12:06:40 -0700
Message-Id: <991940858.7005.1.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Jun 2001 11:49:47 -0400, Derek Glidden wrote:
> Miles Lane wrote:
> > 
> > So please, if you have new facts that you want to offer that
> > will help us characterize and understand these VM issues better
> > or discover new problems, feel free to share them.  But if you
> > just want to rant, I, for one, would rather you didn't.
> 
> *sigh*
> 
> Not to prolong an already pointless thread, but that really was the
> intent of my original message.  I had figured out a specific way, with
> easy-to-follow steps, to make the VM misbehave under very certain
> conditions.  I even offered to help figure out a solution in any way I
> could, considering I'm not familiar with kernel code.
> 
> However, I guess this whole "too much swap" issue has a lot of people on
> edge and immediately assumed I was talking about this subject, without
> actually reading my original message.

Actually, I think your original message was useful.  It has
spurred a reevaluation of some design assumptions implicit in the VM
in the 2.4 series and has also surfaced some bugs.  It was not you
who I felt was sending enflammatory remarks, it was the folks who
have been bellyaching about the current swap disk space requirements
without offering any new information to help developers remedy
the situation.

So, thanks for bringing the topic up.  :-)

Cheers,
	Miles

