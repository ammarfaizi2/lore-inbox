Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285604AbRLRGNb>; Tue, 18 Dec 2001 01:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285617AbRLRGNS>; Tue, 18 Dec 2001 01:13:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64781 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285604AbRLRGLm>; Tue, 18 Dec 2001 01:11:42 -0500
Date: Mon, 17 Dec 2001 22:10:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <20011218005429.A11346@redhat.com>
Message-ID: <Pine.LNX.4.33.0112172209330.2416-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001, Benjamin LaHaise wrote:

> On Mon, Dec 17, 2001 at 05:11:09PM -0800, Linus Torvalds wrote:
> > I've told you a number of times that I'd like to see the preliminary
> > implementation publicly discussed and some uses outside of private
> > companies that I have no insight into..
>
> Well, we've got serious chicken and egg problems then.

Why?

I'd rather have people playing around with new system calls and _test_
them, and then have to recompile their apps if the system calls move
later, than introduce new system calls that haven't gotten any public
testing at all..

		Linus

