Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbTDIAKb (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 20:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTDIAKb (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 20:10:31 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:59916 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S262635AbTDIAKa (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 20:10:30 -0400
Date: Wed, 9 Apr 2003 02:21:59 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Werner Almesberger <wa@almesberger.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <20030408195305.F19288@almesberger.net>
Message-ID: <Pine.LNX.4.44.0304090213500.5042-100000@serv>
References: <200303311541.50200.pbadari@us.ibm.com> <Pine.LNX.4.44.0304031256550.5042-100000@serv>
 <20030403133725.GA14027@win.tue.nl> <Pine.LNX.4.44.0304031548090.12110-100000@serv>
 <b6s3tm$i2d$1@cesium.transmeta.com> <Pine.LNX.4.44.0304071742490.12110-100000@serv>
 <Pine.LNX.4.44.0304072351110.12110-100000@serv> <20030408195305.F19288@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 8 Apr 2003, Werner Almesberger wrote:

> Roman Zippel wrote:
> > Date:   Mon, 7 Apr 2003 22:10:11 +0200 (CEST)
> [...]
> > Date: 	Mon, 7 Apr 2003 23:57:56 +0200 (CEST)
> [...]
> > Ok, Peter refuses to give me an answer to that,
> 
> That was a quick conclusion, after less than two hours :-)

I should have inserted a "privately" there, because there a few mails and 
even a small irc conversation inbetween.

> Anyway, I agree with your general concern. It only seems good
> engineering practice to also look at the numbering schemes that
> are supposed to go with the device number enlargement.
> 
> Or, alternatively, to make sure that it's trivial to make further
> enlargements (or shrinkages), if the need for them should arise.
> I didn't look at the issue in detail, but perhaps the latter is
> the case ?

It was really a mistake from Peter to point me to the archives, it's 
really amazing to how much crap from the static device number crew had to 
be objected by Linus and Al.

bye, Roman

