Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266865AbTAIQnu>; Thu, 9 Jan 2003 11:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbTAIQnu>; Thu, 9 Jan 2003 11:43:50 -0500
Received: from cibs9.sns.it ([192.167.206.29]:3076 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S266865AbTAIQnr>;
	Thu, 9 Jan 2003 11:43:47 -0500
Date: Thu, 9 Jan 2003 17:51:49 +0100 (CET)
From: venom@sns.it
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: vlad@geekizoid.com, "'John Alvord'" <jalvo@mbay.net>,
       <linux-kernel@vger.kernel.org>, <rms@gnu.org>
Subject: Re: What's in a name?
In-Reply-To: <Pine.LNX.3.95.1030109110746.10873A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.43.0301091740420.10782-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, for binaries most of the time we even did not need to use the
/usr/lib/libbsd.a compatibility library
and the /usr/include/bsd/*.h compatibility includes
(just ash was needing that) coming with libc4 and libc5 distribution for
compatibility pursues.

Then also the boot system was BSD like, and now we see this prosecuted and
evolved in Slackware.

But please, let's stop this thread.

We talked about GPLed modules and binary only modules,
and none even considered implication brought
by the new module interface with run queue, that is an important
point in this discussion.

We talked just about names, names, names, and again names.
I do not expect in every thread on lkml to see some good contribution
(not just code, but concept, discussions, and so on),
but this specific one is just like
"the wall I build with my belief is higher than your".

And the few smart mails ususally got ignored.
There is no interess in this for me.

Luigi



On Thu, 9 Jan 2003, Richard B. Johnson wrote:

> Most all of the early distributions
> used programs ported from BSD. The Linux-BSD emulation was so good,
> thanks to Linus and others, that most programs needed to only be
> recompiled.
>
> That, ladies and gentlemen, is the true history of the "Linux Operating
> System" with all of the components that RMS insists are his, actually
> coming from the University of California, Berkeley.
>

