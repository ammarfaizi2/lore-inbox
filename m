Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264898AbSIWC0e>; Sun, 22 Sep 2002 22:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264902AbSIWC0e>; Sun, 22 Sep 2002 22:26:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54289 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264898AbSIWC0d>; Sun, 22 Sep 2002 22:26:33 -0400
Date: Sun, 22 Sep 2002 19:32:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter Rival <frival@zk3.dec.com>
cc: Jochen Friedrich <jochen@scram.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.38
In-Reply-To: <3D8E7214.8020600@zk3.dec.com>
Message-ID: <Pine.LNX.4.44.0209221930560.1208-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Sep 2002, Peter Rival wrote:
>
> Patch below fixes the problem.  Linus, please apply.  Here's hoping Mozilla
> doesn't blow up the patch

It does (or something else does) - tabs have been space'ified.

What the hell is _wrong_ with mail client authors that they can't get
something as simple as keeping a file intact _correct_? Why do email
clients think they have to corrupt the input on something as simple as
plain 7-bit ascii (oe even 8-bit latin1, for that matter)? Silly buggers.

Please complain to the mozilla people.

		Linus

