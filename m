Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUCJWjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbUCJWjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:39:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:53639 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261313AbUCJWjN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:39:13 -0500
Date: Wed, 10 Mar 2004 17:42:20 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: David Ford <david+challenge-response@blue-labs.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, "Randy.Dunlap" <rddunlap@osdl.org>,
       "Godbole, Amarendra (GE Consumer & Industrial)" 
	<Amarendra.Godbole@ge.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Re: (0 == foo), rather than (foo == 0)
In-Reply-To: <404F949E.1020905@blue-labs.org>
Message-ID: <Pine.LNX.4.53.0403101724250.24470@chaos>
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>
 <20040310100215.1b707504.rddunlap@osdl.org> <Pine.LNX.4.53.0403101324120.18709@chaos>
 <404F6375.3080500@blue-labs.org> <20040310212942.GB31500@parcelfarce.linux.theplanet.co.uk>
 <404F949E.1020905@blue-labs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, David Ford wrote:

> I won't.  I didn't say anything against inability to preserve line
> boundaries.  I was, and am, referring to linear text and letting the end
> user reflow that text to suit his or her preferences.
>

Hmmm. What is linear text? Is it okay to auto-wrap i
n
t
he
mid
dle of text, not on white-space boundaries, like it
does when somebody just streams out a bunch of bytes?

> viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> >Kindly piss off.  My mail reading software uses vi(1) to compose the
> >reply and has enough sense to preserve the line boundaries.
> >
> >
>

The pine mailer that I use, uses pico as its editor. When I attempt
to write a response that has previous quotes, the stuff that doesn't
fit on a line just piles up at the end of the window. It gets replaced
by a '$' so you know that there is more text. `vi` isn't so kind.
You don't know what's hidden unless you put a new-line in at the
end or want to space to the right up to 4094 bytes (it allows lines
to be that long, last I checked). With vi, you get a line of text like thi

You don't know what's beyond the 'i' of "thi", above. It might
be several hundred important words so you need to space the cursor
over there and look beyond the screen boundaries.

When you want text to be read by others, you make sure they
can read it. It's just that simple. There are some assumptions
that you can make. You can assume that they have a way of
reading 80-column text, for instance.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


