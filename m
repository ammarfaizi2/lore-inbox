Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310749AbSDEBmf>; Thu, 4 Apr 2002 20:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310953AbSDEBmZ>; Thu, 4 Apr 2002 20:42:25 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:62341 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S310749AbSDEBmP>; Thu, 4 Apr 2002 20:42:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Thu, 4 Apr 2002 18:40:46 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>, Larry McVoy <lm@bitmover.com>
In-Reply-To: <Pine.LNX.4.33.0204041720210.1546-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020405014212Z16157-8743+585@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On April 5, 2002 03:21 am, Linus Torvalds wrote:
> On Thu, 4 Apr 2002, Albert D. Cahalan wrote:
> > 
> > So then something like this...
> > 
> > alias ls='/bin/ls --ignore=SCCS'
> 
> Oh, that's very useful. Considering that everything else still finds them, 
> like find, shell autocompletion etc.
> 
> The only thing "--ignore=xxx" is useful for is hackers that want to break 
> into your system and hide their files.

And anyway, Larry sorta/kinda agreed to let us hide his bk metadata in one or
more hidden files, and when I grab him for clubbing^W dinner in a few days
I'll have a good chance to beat on him further to actually get that little
feature, which means more to me than it really should, personally.

-- 
Daniel
