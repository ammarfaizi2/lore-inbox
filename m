Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130582AbRAZVMl>; Fri, 26 Jan 2001 16:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbRAZVMW>; Fri, 26 Jan 2001 16:12:22 -0500
Received: from [63.95.13.242] ([63.95.13.242]:20320 "EHLO
	zso-powerapp-01.zeusinc.com") by vger.kernel.org with ESMTP
	id <S130147AbRAZVMQ>; Fri, 26 Jan 2001 16:12:16 -0500
Message-ID: <006d01c087dc$7dd7e670$1a040a0a@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: <barryn@pobox.com>, "Michael B. Trausch" <fd0man@crosswinds.net>
Cc: "Georg Nikodym" <georgn@somanetworks.com>, <linux-kernel@vger.kernel.org>,
        "Alan Cox" <alan@redhat.com>, "Zack Brown" <zab@redhat.com>
In-Reply-To: <200101262057.MAA02372@cx518206-b.irvn1.occa.home.com>
Subject: Re: Possible Bug:  drivers/sound/maestro.c
Date: Fri, 26 Jan 2001 16:11:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I haven't done any sound stuff with 2.4 on my Dell Inspiron 5000e, but I
> have this problem (or a similar one, anyway -- sometimes the sound becomes
> distorted or comes only through one speaker) under both Linux 2.2 and
> Win2K. If it was just Linux, I'd assume it was a driver problem, but the
> fact that I'm getting very similar misbehavior from both Linux and Win2K

Just to add a note, my Dell Inspiron 5000e also exhibits this problem under
both Linux and W2K.  I've never heard it happen under Win98 but I spend very
little time actually running that OS (I occasionally boot it to troubleshoot
client issues that are still running on Win95/98) compared to the others so
that probably doesn't mean a lot.

I've also tried the ALSA drivers on this machine but have never has success
in even getting their Maestro driver to work on this machine.  I do have
ALSA drivers working on several desktop machines at home and have always had
good success with them, but they fail miserably for me on this laptop.  I
haven't tried the absolute latest version released earlier this week though,
maybe over the weekend.

> (I don't have Win98 or ME on the machine, so I can't test that) makes me
> really wonder...

It makes me wonder as well, maybe I'll try to force myself to use Win98 for
a while and see if I can force the problem to occur there as well.

Later,
Tom



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
