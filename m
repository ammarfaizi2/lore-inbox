Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317430AbSGXRjC>; Wed, 24 Jul 2002 13:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317435AbSGXRjB>; Wed, 24 Jul 2002 13:39:01 -0400
Received: from trained-monkey.org ([209.217.122.11]:40202 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S317430AbSGXRjB>; Wed, 24 Jul 2002 13:39:01 -0400
To: kwijibo@zianet.com
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: 3com 3c996b-t support?
References: <Pine.LNX.4.33.0207241314550.30282-100000@coffee.psychology.mcmaster.ca> <3D3EE4B1.3000809@zianet.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 24 Jul 2002 13:42:11 -0400
In-Reply-To: kwijibo@zianet.com's message of "Wed, 24 Jul 2002 11:32:33 -0600"
Message-ID: <m3adohja4s.fsf@trained-monkey.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Steve" == kwijibo  <kwijibo@zianet.com> writes:

Steve> http://www.cs.uni.edu/~gray/gig-over-copper/

Steve> The 3com drivers are open-source though, which makes me less
Steve> hesitent.  And the tigon3 drivers lack of documentation kind of
Steve> irks me.  I would however like to stick with a mainstream
Steve> kernel driver cause the support is there if it is needed.  I
Steve> guess I will give both versions a whirl.  From just glancing at
Steve> the source of both, it seems that both versions support jumbo
Steve> frames which is really what I am after.

Well did you look at the code? It's the infamous Broadcom bcm5700
driver which is probably the worst driver code we have seen in the
Linux community for the last 5 years. Sure you can run it, but don't
come back and complain when you run into trouble. You will be a lot
better off using the tg3 driver, or better yet, getting a NIC thats
less buggy.

Cheers,
Jes
