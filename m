Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277148AbRJDGzh>; Thu, 4 Oct 2001 02:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277145AbRJDGz3>; Thu, 4 Oct 2001 02:55:29 -0400
Received: from chiara.elte.hu ([157.181.150.200]:28169 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S277144AbRJDGzJ>;
	Thu, 4 Oct 2001 02:55:09 -0400
Date: Thu, 4 Oct 2001 08:52:20 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ben Greear <greearb@candelatech.com>
Cc: jamal <hadi@cyberus.ca>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <3BBC06A1.1818E45C@candelatech.com>
Message-ID: <Pine.LNX.4.33.0110040851280.2166-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Oct 2001, Ben Greear wrote:

> > so far your appraoch is that of a shotgun i.e  "let me fire in
> > that crowd and i'll hit my target but dont care if i take down a few
> > more"; regardless of how noble the reasoning is, it's  as Linus described
> > it -- a sledge hammer.
>
> Aye, but by shooting this target and getting a few bystanders, you save
> everyone else...  (And it's only a flesh wound!!)

especially considering that the current code nukes the whole city ;)

	Ingo

