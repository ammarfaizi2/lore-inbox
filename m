Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262716AbSIPQTn>; Mon, 16 Sep 2002 12:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbSIPQTn>; Mon, 16 Sep 2002 12:19:43 -0400
Received: from Morgoth.ESIWAY.NET ([193.194.16.157]:56081 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S262716AbSIPQTm>; Mon, 16 Sep 2002 12:19:42 -0400
Date: Mon, 16 Sep 2002 18:24:21 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Larry McVoy <lm@bitmover.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <20020915191318.C22354@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0209161754020.26363-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002, Larry McVoy wrote:

[...]
> people hacking about in that code.  Either understand it and really fix
> it, own it, maintain it, live with it, or leave it alone.  
> 
> You may have a different opinion, Alan, and that's fine.  All that
> means is that you won't ever work here.  One of the nice things about
> being the guy who runs the company is that you get to insist on a certain
> level of competence and professionalism or you're fired.  It's one of
> the reasons I don't work for someone else, I like being able to say
> "do it right or don't do it, I pay the bills, that's what I want".
> I learned that at Sun, over my every objection because I was an idiot,
> but I learned it.  After you learn the benefits of doing things right
> you have nothing but pity for people who do it wrong.

Larry, you tend to use words like 'company' and 'business' too much in
your messages... B-)

Suppose that I (definitely not a guru - I deal with the Linux kernel just
for fun, and I don't *need* any *professional* knowledge on it) find some
obscure bug (maybe I'm using some uncommon HW). I understand *nothing*
about the piece of kernel that actually BUG()s - probably it's the 
first time I see it. Nevertheless, I *like* kernel hacking. So I start
chasing the bug (and a debugger helps me a lot). It takes hours/days but
who cares? I'm having fun. Later I come up with a patch, which seems to
fix it. It may be complete crap. But I send a bug report *and* my patch
to Alan (or J. Kernel Mantainer). In a hour I get a reply back, saying:
"your patch is wrong, but I see the bug and I've fixed it in my tree"
(that's because *he* knows the code).

Don't you think that even random and clueless hacking can be (at times)
a valuable source of information for real hackers? That's very open
source specific, of course you don't run a *company* like that, but who
cares? Many of the lessons you learned in your business career
apply here, but some simply don't. The Linux kernel development isn't
run by someone that pays the bills...

.TM.

