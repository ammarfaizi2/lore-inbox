Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262070AbTCHQ1Y>; Sat, 8 Mar 2003 11:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262074AbTCHQ1Y>; Sat, 8 Mar 2003 11:27:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36356 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262070AbTCHQ1X>; Sat, 8 Mar 2003 11:27:23 -0500
Date: Sat, 8 Mar 2003 08:35:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: zippel@linux-m68k.org, <david.lang@digitalinsight.com>, <hpa@zytor.com>,
       <rmk@arm.linux.org.uk>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <20030308.080317.27972826.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0303080826300.2954-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Mar 2003, David S. Miller wrote:
> 
> Note how I used the word "could" not "should" or "must".

Yeah. And I note how Roman and others also didn't say "you _must_ change 
it to the GPL".

The thing is, this discussion has _not_ been exactly neutral. You may have 
said "could" or "might" or whatever, but clearly people are trying to 
pressure hpa into going to GPL. It's the whole tone of the thread.

Or would you disagree with that?

Hey, I'm a GPL user myself, obviously. I don't much like the BSD license,
and no project _I_ start is likely to ever be under that license. In fact,
I seriously doubt that I'd ever really even want to get seriously involved
with a project that could just be hijacked without source at any time.

However, that doesn't make pressuring hpa about it ok.

Also, you guys should think about what this whole project was about: it's 
about the smallest possible libc. This is NOT a project that should live 
and prosper and grow successful. That's totally against the whole point of 
it, it's not _supposed_ to ever be a glibc-like thing. It's supposed to be 
so damn basic that it's not even _interesting_. It's one of those projects 
that is better off ignored, in fact. It's like a glorified header file.

(At this point hpa asks me to shut up, since I've now depressed him more
than any of the GPL bigots ever did ;)

I can _totally_ see hpa's point that he would be perfectly happy with
people "stealing" parts of it - the code in question is not something that
anybody should _ever_ have to re-create, even if he's the most evil person
on earth and hates the GPL and wants to kill us all. Because it's not
_worth_ recreating.

			Linus

