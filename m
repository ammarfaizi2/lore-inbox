Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277271AbRJDXwC>; Thu, 4 Oct 2001 19:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277270AbRJDXvy>; Thu, 4 Oct 2001 19:51:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50951 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277273AbRJDXvn>; Thu, 4 Oct 2001 19:51:43 -0400
Date: Thu, 4 Oct 2001 16:51:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: Benjamin LaHaise <bcrl@redhat.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>, <mingo@elte.hu>,
        jamal <hadi@cyberus.ca>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>, <netdev@oss.sgi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <1002239236.872.8.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0110041650410.975-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Oct 2001, Robert Love wrote:
>
> Agreed.  I am actually amazed that the opposite of what is happening
> does not happen -- that more people aren't clamoring for this solution.

Ehh.. I think that most people who are against Ingo's patches are so
mainly because there _is_ an alternative that looks nicer.

		Linus

