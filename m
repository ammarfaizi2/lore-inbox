Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317446AbSGXSFO>; Wed, 24 Jul 2002 14:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317454AbSGXSFN>; Wed, 24 Jul 2002 14:05:13 -0400
Received: from trained-monkey.org ([209.217.122.11]:44810 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S317446AbSGXSFN>; Wed, 24 Jul 2002 14:05:13 -0400
To: kwijibo@zianet.com
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: 3com 3c996b-t support?
References: <Pine.LNX.4.33.0207241314550.30282-100000@coffee.psychology.mcmaster.ca> <3D3EE4B1.3000809@zianet.com> <m3adohja4s.fsf@trained-monkey.org> <3D3EED72.1080809@zianet.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 24 Jul 2002 14:08:25 -0400
In-Reply-To: kwijibo@zianet.com's message of "Wed, 24 Jul 2002 12:09:54 -0600"
Message-ID: <m37kjlj8x2.fsf@trained-monkey.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Steve" == kwijibo  <kwijibo@zianet.com> writes:

Steve> Jes Sorensen wrote:

>> driver which is probably the worst driver code we have seen in the
>> Linux community for the last 5 years. Sure you can run it, but
>> don't come back and complain when you run into trouble. You will be
>> a lot better off using the tg3 driver, or better yet, getting a NIC
>> thats less buggy.

Steve> Is the NIC hardware buggy or is it just the bcm5700 drivers?

The hardware is buggy. The bcm5700 drivers are written in such
terrible C, you can in fact argue whether you'd call it C, that it's
totally impossible to debug the code anyway. Who knows whats hidden in
there.

Jes
