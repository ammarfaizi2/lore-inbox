Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285663AbRLTAOh>; Wed, 19 Dec 2001 19:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285668AbRLTAO2>; Wed, 19 Dec 2001 19:14:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20352 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285663AbRLTAOS>;
	Wed, 19 Dec 2001 19:14:18 -0500
Date: Wed, 19 Dec 2001 16:13:59 -0800 (PST)
Message-Id: <20011219.161359.71089731.davem@redhat.com>
To: bcrl@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011219135708.A12608@devserv.devel.redhat.com>
In-Reply-To: <E16Gjuw-0000UT-00@starship.berlin>
	<Pine.LNX.4.33.0112190859050.1872-100000@penguin.transmeta.com>
	<20011219135708.A12608@devserv.devel.redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben LaHaise <bcrl@redhat.com>
   Date: Wed, 19 Dec 2001 13:57:08 -0500
   
   Thanks for the useful feedback on the userland interface then.  Evidently 
   nobody cares within the community about improving functionality on a 
   reasonable timescale.  If this doesn't change soon, Linux is doomed.

Maybe it's because the majority of people don't care nor would ever
need to use AIO.  Are you willing to accept this possibly? :-) Linux
is anything but doomed, because you will notice that the things that
actually matter for most people are in fact improved and worked on
within a reasonable timescale.

Only very specialized applications can even benefit from AIO.  This
doesn't make it useless, but it does decrease the amount of interest
(and priority) anyone in the community will have in working on it.

Now, if these few and far between people who are actually interested
in AIO are willing to throw money at the problem to get it worked on,
that is how the "reasonable timescale" will be arrived at.  And if
they aren't willing to toss money at the problem, how important can it
really be to them? :-)

Maybe, just maybe, most people simply do not care one iota about AIO.

Linux caters to the general concerns not the nooks and cranies, that
is why it is anything but doomed.
