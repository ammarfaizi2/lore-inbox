Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318774AbSG0Pmi>; Sat, 27 Jul 2002 11:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318775AbSG0Pmi>; Sat, 27 Jul 2002 11:42:38 -0400
Received: from monster.nni.com ([216.107.0.51]:48136 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S318774AbSG0Pmi>;
	Sat, 27 Jul 2002 11:42:38 -0400
Date: Sat, 27 Jul 2002 11:45:09 -0400
From: Andrew Rodland <arodland@noln.com>
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Speaker twiddling [was: Re: Panicking in morse code]
Message-Id: <20020727114509.0a1eee2a.arodland@noln.com>
In-Reply-To: <3D4298C6.9080103@sktc.net>
References: <20020727000005.54da5431.arodland@noln.com>
	<200207270526.g6R5Qw942780@saturn.cs.uml.edu>
	<20020727015703.21f47a37.arodland@noln.com>
	<3D4298C6.9080103@sktc.net>
X-Mailer: Sylpheed version 0.7.8claws55 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2002 07:57:42 -0500
"David D. Hagood" <wowbagger@sktc.net> wrote:

> I don't understand the direction this discussion is taking.
> 
> Either you are trying to output the panic information with minimal 
> hardware, and in a form a human might be able to decode, in which case
> the Morse option seems to me to be the best, or you are trying to
> panic in a machine readable format - in which case just dump the data
> out /dev/ttyS0 and be done with it!
> 
> To my way of thinking, the idea of the Morse option is that if an oops
> 
> happens when you are not expecting it, and you haven't set up any 
> equipment to help you, you still have a shot at getting the data.


To my way of thinking, this is still 'minimal' -- it's just a different
minimum.

It's the 'minimum' way to get the panic message out digitally, in such
a way that I might be able to recover it using a tape recorder or a
telephone. Actually, morse is probably that, but morse loses data and
doesn't have any redundancy.

And with a setup pretty similar to what acalahan posted, It can be
written with a minimum of complexity (maybe less than morse) and
hardware (still just pc speaker).

Anyway, I don't expect for other people to use most of what I'm going
to be playing with with this, and my (disconnected) vacation next week
provides the perfect opportunity for me to play with it all I want
without bothering the list. And I've got some mighty interesting ideas
now.

Thanks
--hobbs
