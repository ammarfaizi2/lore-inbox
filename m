Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbUCWRTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 12:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUCWRTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 12:19:33 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:3307 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S262709AbUCWRTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 12:19:32 -0500
Date: Tue, 23 Mar 2004 19:18:24 +0200 (EET)
From: =?iso-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>
X-X-Sender: midian@midi.ihme.net
To: Jos Hulzink <josh@stack.nl>
cc: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OSS: cleanup or throw away
In-Reply-To: <20040323112305.F52644@toad.stack.nl>
Message-ID: <20040323191330.W29917@midi.ihme.net>
References: <200403221955.52767.jos@hulzink.net> <20040322202220.GA13042@mulix.org>
 <20040323082338.GD23546@lgb.hu> <20040323112305.F52644@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004, Jos Hulzink wrote:
> Maybe we should start ditching OSS drivers of cards that are known to work
> "reasonably well" in ALSA. If someone starts screaming "I need OSS for the
> ALSA driver contains a bug", that bug might even be located and dealt with
> much sooner. The ALSA OSS emulation is good enough for user land
> applications to survive I think, so it's just a matter of driver bugs.
>
Not true.

> This way we end with a list of OSS drivers that are not ported yet or that
> never will be ported.
>
> OTOH, I don't know how the big bosses here think about ditching OSS
> from a stable kernel tree... Can imagine they think it is not done.
>
Good idea, then maybe someone will fix the bug that makes ALSA unusable
for me. (Or maybe it's a feature? O_o)

I don't describe it here, I've sent a few mails about it, no response, so
I don't wait for any response this time either, so why bother.

	Markus
