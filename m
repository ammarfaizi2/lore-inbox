Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266827AbRGOSZ3>; Sun, 15 Jul 2001 14:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266822AbRGOSZU>; Sun, 15 Jul 2001 14:25:20 -0400
Received: from clavin.efn.org ([206.163.176.10]:57286 "EHLO clavin.efn.org")
	by vger.kernel.org with ESMTP id <S266818AbRGOSZI>;
	Sun, 15 Jul 2001 14:25:08 -0400
From: Steve VanDevender <stevev@efn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15185.57310.203036.847687@tzadkiel.efn.org>
Date: Sun, 15 Jul 2001 11:24:30 -0700
To: "George Bonser" <george@gator.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Linux default IP ttl
In-Reply-To: <CHEKKPICCNOGICGMDODJKEFADKAA.george@gator.com>
In-Reply-To: <15185.32479.520720.444617@pizda.ninka.net>
	<CHEKKPICCNOGICGMDODJKEFADKAA.george@gator.com>
X-Mailer: VM 6.94 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Bonser writes:
 > I really do not care WHY it works, all I care is that it DOES work. I am not
 > the least bit interested given the current economy of things to try to bully
 > people into doing what is right. I am more interested in operating with the
 > client population that is out there without having to make them change
 > anything.

You do of course realize that your problem was caused by other people
who probably have exactly the same attitude as you do -- they didn't
care whether they were doing the right thing, they just slapped together
something that worked, even if it did introduce way too many routing
hops.  So you're introducing a kludge to counteract their kludge, and
eventually this all turns into a big pile of kludges that doesn't work.

To the extent that the Internet works today, it's because people have
chosen to do the right thing instead of just the thing that works.
Encouraging (not "bullying") other people to do the right thing is
always a good idea.
