Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286223AbRLJKwn>; Mon, 10 Dec 2001 05:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286222AbRLJKwe>; Mon, 10 Dec 2001 05:52:34 -0500
Received: from bzq-165-60.dsl.bezeqint.net ([62.219.165.60]:16136 "EHLO
	the.linux-dude.net") by vger.kernel.org with ESMTP
	id <S286223AbRLJKwR>; Mon, 10 Dec 2001 05:52:17 -0500
Date: Mon, 10 Dec 2001 12:52:11 +0200 (IST)
From: Ido Diamant <ido@the.linux-dude.net>
To: <linux-kernel@vger.kernel.org>
Subject: ip_nat_irc bug?
Message-ID: <Pine.LNX.4.33.0112101251010.4615-100000@the.linux-dude.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 After compiling kernel 2.4.16, I'v seen that I can't dcc chat bots
running on my local computer. I tried to see why its happening, and
couldn't get into any reasonable idea.
Yesterday I remembered that I compiled the 2.4.16 with the ip_nat_irc
module, and loaded it by default with my firewall. I rmmod ip_nat_irc and
suddenly I could dcc chat my local bots.
Q. Why is it happening?
Q. Am I using this module correctly? as far as I know, I just need to load
the module, and thats it, am I wrong? should I create some kind of rule
for it?
Q. Is it bug?

  Thanks,
        Ido Diamant

