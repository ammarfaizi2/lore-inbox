Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286130AbRLJBIf>; Sun, 9 Dec 2001 20:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286131AbRLJBI2>; Sun, 9 Dec 2001 20:08:28 -0500
Received: from shell.cyberus.ca ([216.191.240.114]:27132 "EHLO
	shell.cyberus.ca") by vger.kernel.org with ESMTP id <S286130AbRLJBIS>;
	Sun, 9 Dec 2001 20:08:18 -0500
Date: Sun, 9 Dec 2001 20:04:42 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: bert hubert <ahu@ds9a.nl>
cc: <kuznet@ms2.inr.ac.ru>, <lartc@mailman.ds9a.nl>,
        <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: CBQ MANPAGE: I hear the theme of '2001, A Space Odyssey'
In-Reply-To: <20011210014130.A27193@outpost.ds9a.nl>
Message-ID: <Pine.GSO.4.30.0112092001180.6079-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry didnt read it; did the 30 sec scan ..
If this is meant to be for users, why are you talking about skb->priority?
Isnt it sufficient to just call it prioirity?
Also, if you think that Alexeys imp. is based on Floyd only, you are
highly mistaken;
Going back to high latency response mode ...

cheers,
jamal

On Mon, 10 Dec 2001, bert hubert wrote:

> ... to the sound of 'Also sprach Zarathustra':
>
>  After weeks of social deprivation and much digging through heaps of code, I
>                                   bring you
>
>                                   tc-cbq.8
>
>        The CBQ manpage. Nearly 2500 words, 8 printed pages, of nearly
>         unintelligible gobledygook, explaining mostly how CBQ works.
>
> It is part of the Linux Advanced Routing & Traffic Control documentation
> project which contains a HOWTO, a mailinglist, an IRC channel and now
> manpages:
>
>                             http://ds9a.nl/lartc
>
> I want to thank Jamal for stubbornly straightening me out when I use messy
> language and explaining how things work. The errors are mine though.
>
> I *implore* ANK and others to read through this. I'm about exhausted and
> running out of time (need to get on with work), and have a hard time
> figuring out the exact details of the CBQ link sharing algorithm. I need
> help, so to speak. The manpage indicates where.
>
> Thanks for your attention. Please find tc-cbq.8 attached.
>
> Regards,
>
> bert hubert
>
>
> --
> http://www.PowerDNS.com          Versatile DNS Software & Services
> Trilab                                 The Technology People
> Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
> 'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
>

