Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSL1PcO>; Sat, 28 Dec 2002 10:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSL1PcO>; Sat, 28 Dec 2002 10:32:14 -0500
Received: from fluent2.pyramid.net ([206.100.220.213]:4744 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP
	id <S262789AbSL1PcN>; Sat, 28 Dec 2002 10:32:13 -0500
Message-Id: <5.2.0.9.0.20021228073445.01d386c0@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sat, 28 Dec 2002 07:40:29 -0800
To: linux-kernel@vger.kernel.org
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Want a random entropy source?
In-Reply-To: <20021228104213.7DA7B2C07C@lists.samba.org>
References: <Your message of "Fri, 27 Dec 2002 17:16:35 BST." <200212271616.RAA03356@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not too long ago I had made a submission on SlashDot on something-or-other 
(oh, right, "Rube-Goldberg Type Random Number Generators?" 
http://ask.slashdot.org/article.pl?sid=02/07/26/1751228&tid=137) and I 
stumbled across my submission to that article.  After thinking about it, I 
though it might be a reasonable thing to submit to this list as a possible 
enhancement to the /dev/random driver if someone wants to try it.  My 
submission was thus:

"I've been vexed that the sound card plus CD-ROM drive combination always 
shows signal at around -50 dBVU in CoolEdit. So, just for grins, I decided 
to capture a few seconds of the noise and analyze the properties. I was 
astonished to see that the resulting signal is a white-noise pattern with a 
slight emphasis at the high end (when sampled at 44 kilosamples per 
second). In short, it looks like diode noise with a 4 kilohertz square wave 
thrown in.

"That suggests to me that this would make a fair source of random samples, 
especially after you slot out the interfering signal.

"How many computers don't have cheap sound cards and CD-ROM drives?"

For what it's worth...

Satch

