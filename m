Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265357AbUATI7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 03:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265363AbUATI7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 03:59:09 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:47059 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S265357AbUATI65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 03:58:57 -0500
Date: Tue, 20 Jan 2004 09:58:53 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Travis Morgan <lkml@bigfiber.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ALSA vs. OSS
Message-ID: <20040120085853.GC11143@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <1074532714.16759.4.camel@midux> <microsoft-free.87vfn7bzi1.fsf@eicq.dnsalias.org> <1074536486.5955.412.camel@castle.bigfiber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1074536486.5955.412.camel@castle.bigfiber.net>
X-Operating-System: vega Linux 2.6.1 i686
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 11:21:26AM -0700, Travis Morgan wrote:
> So far I sort of tend to agree with you on OSS being better.

Please. This is a minor point, the important part is hidden from an average
user, that ALSA is modularized, supports SMP, multiple sound cards etc etc,
so it is much better structured than OSS/Free. Of course some DRIVER is in
better/worse in ALSA than in OSS/Free. But it's a minor point, the main
advantage is the whole structure of the sound layer Linux has, which is much
more better with ALSA than with OSS/Free. The base structure is the hard
work, porting drivers from eg OSS/Free or enhance it in ALSA can be minor
work. Also, user base of OSS/Free is MUCH larger than ALSA's just because
ALSA _was_ a separated project till now, so maybe features provided towards
users are not so clean than in the case of OSS/Free which was the part of
kernel since ages. But I think this is exactly the reason OSS/Free and ALSA
are available in paralell for a while, so developers have got time to
do something.

It's like when 'new operating system' is described after its GUI in the m$
world, while it's not a major point when speaking about an OS ;-)

- Gábor (larta'H)
