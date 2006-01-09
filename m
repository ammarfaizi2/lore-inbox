Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751655AbWAIXz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbWAIXz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 18:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWAIXz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 18:55:59 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:143 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751654AbWAIXz6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 18:55:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mW50fvzRkIDm5nwf/JEY4mq0wFLaCpmFWUjGk3739iMPwwZsT/Rsr9haPxDMy+J/ckz6xjgcJlXSt8bMcpRndmKZvqdApkiSF5JWL6Rt+OKPWN7pSQ5us1rZvasT3ysWlFZQFAMv4RVT/Zz03+nOIgu1mOIqJQz/dq/EXE3JvSU=
Message-ID: <5a2cf1f60601091555r4f9d9c58ie10d821342e8461b@mail.gmail.com>
Date: Tue, 10 Jan 2006 00:55:57 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: [OT] ALSA userspace API complexity
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <43BE8A04.6080603@stesmi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050726150837.GT3160@stusta.de>
	 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
	 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
	 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>
	 <s5hmziaird8.wl%tiwai@suse.de>
	 <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi>
	 <1136504460.847.91.camel@mindpipe>
	 <4A284096-E889-4E6D-B017-B8241CD72A0D@dalecki.de>
	 <1136510509.9382.24.camel@localhost> <43BE8A04.6080603@stesmi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Stefan Smietanowski <stesmi@stesmi.com> wrote:
[...]

> Same as when Renault introduced the keyless system in the Laguna in 2001
> (some call it the Laguna II) - it's basically a card you stick into a
> slot in the console which enables you to just press a button to start
> the car instead of turning a key and it also contained memory about
> your chair settings, mirrors and volume/sound settings of the radio.
>
> Now, is this a highly complex piece of software running there to do
> those things?
>
> Regardless of how what someone believes - a few months later someone
> was out driving and all of a sudden the car started speeding up and
> since there was no key you couldn't turn the car off and the breaks
> weren't strong enough to slow the car down and running at roughly
> 200kph he managed to YANK the card out of the slot before it could be
> slowed down and the ignition turned off - the guy was lucky to be
> alive.

I think you are mixing 2 stories. According to my sources, the driver
of a Renault Vel Satis reported a similar issue and got stuck at
around 190kmph during an hour in October 2004. In March 2005, the
driver of a Laguna reported that he got stuck at 90 kmph for 40km.

> It turns out that it was a combination of a bug in the keyless
> system AND the cruise control that made this happen - two bugs
> that in themselves wouldn't have triggered but at the right speed,
> and when everything matched things went haywire, so no, no matter
> how tight you write specifications or papers you can't get
> everything bugfree, even in such a simple system as a keycard
> for your car. Note that one of the bugs WAS in the keycard.

To my knowledge, none of the reported issues have yet been identified
as coming from the car. I searched again before posting and found no
reference to that issue.

I would be happy to know where you found this information. At least to
know if the constructors are hidding something.

Cheers,

> // Stefan

Jerome
