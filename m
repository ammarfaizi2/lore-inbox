Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272579AbRIFUlR>; Thu, 6 Sep 2001 16:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272566AbRIFUlA>; Thu, 6 Sep 2001 16:41:00 -0400
Received: from spike.porcupine.org ([168.100.189.2]:54282 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S272579AbRIFUko>; Thu, 6 Sep 2001 16:40:44 -0400
Subject: Re: [PATCH] ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
In-Reply-To: <Pine.GSO.4.30.0109061612450.14727-100000@shell.cyberus.ca>
 "from jamal at Sep 6, 2001 04:20:39 pm"
To: jamal <hadi@cyberus.ca>
Date: Thu, 6 Sep 2001 16:41:04 -0400 (EDT)
Cc: Wietse Venema <wietse@porcupine.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kuznet@ms2.inr.ac.ru, Matthias Andree <matthias.andree@gmx.de>,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010906204104.A3FBDBC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please stop that BSD versus Linux drivel. Either make a constructive
contribution or be silent.

I don't care what API is "superior", as long as it provides me with
the information that I want.

	Wietse

jamal:
> 
> 
> On Thu, 6 Sep 2001, Wietse Venema wrote:
> 
> > Alan Cox:
> > > > Soldiers are marching down the street. The mother of one of those
> > > > soldiers is ever so proud.  All the other guys are marching out of
> > > > step.  Her son is the only one who does it right.
> > > >
> > > > That's what it looks like for a person who writes Internet software
> > > > that aims to work on a wide variety of platforms.
> > >
> > > I think you have the metaphor wrong. The older API is a bit like the
> > > cavalry charging into battle at the start of world war one. It may have been
> > > how everyone did it but they guys with the "newfangled, really not how it
> > > should be done, definitely not cricket"  machine guns got the last laugh
> >
> > Keep your superiority complex out of my mailbox, thank you.
> >
> 
> Wietse,
> 
> netlink, as a few people have pointed to you is the 'proper' way to do
> things. Sure, the BSDs did it the way you love it, but linux is a
> different operating system (cut the "if its not Scottish its crap
> mentality"). Netlink does improve on "the way its always been done for
> the last 80 years". Infact netlink has already been approved to be (at
> least informational) RFC. Look at a slightly dated draft at:
> http://search.ietf.org/internet-drafts/draft-salim-netlink-jhshk-00.txt
> Maybe you should preach to the BSDs about netlink?
> 
> cheers,
> jamal
> 
> PS:- If you want help on writting netlink based code to achieve what you
> are trying to do, just yell. Look at the source for the ip utility which
> is within the iproute2 package.
> 
> 

