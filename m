Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286517AbRLUBpI>; Thu, 20 Dec 2001 20:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286523AbRLUBo6>; Thu, 20 Dec 2001 20:44:58 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:43063 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S286517AbRLUBon>; Thu, 20 Dec 2001 20:44:43 -0500
Message-Id: <4.3.2.7.2.20011220173854.031ccdd0@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 20 Dec 2001 17:44:23 -0800
To: Michael Dunsky <michael.dunsky@p4all.de>,
        Matt Bernstein <matt@theBachChoir.org.uk>
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in
  Configure.help.
Cc: Steven Cole <scole@lanl.gov>, esr@thyrsus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C223255.5020107@p4all.de>
In-Reply-To: <Pine.LNX.4.43.0112201810340.16545-100000@nick.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:47 PM 12/20/01 +0100, Michael Dunsky wrote:
>You are close - he uses "MiB" as short for "mebi" - Mega-binary.
>Don't laugh - this is official! It's exactly for what you said:
>[snip]
>For a short reading I recommend this:
>
>http://physics.nist.gov/cuu/Units/binary.html

Yet on this page you point to, the first paragraph under the table reads as 
follows:

"It is important to recognize that the new prefixes for binary multiples 
are not part of the International System of Units (SI), the modern metric 
system."

That disclaimer makes it highly UNofficial.

It also goes against legacy use, as well as use within the kernel and GNU 
utilities for informative messages.

We have enough problem introducing non-technical people to Linux as it is 
without inflicting new and obscure abbreviations.  Notice that the 
discussion is about changes to Configure.help, the WORST place to start 
introducing new and not-widely-used notation.

Hey, it's not a bad idea, but I want it adopted first in things like 
stories in the mass media before we start introducing it in Configure.help.

Stephen Satchell


