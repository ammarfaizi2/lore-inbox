Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSGTERG>; Sat, 20 Jul 2002 00:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317361AbSGTERG>; Sat, 20 Jul 2002 00:17:06 -0400
Received: from cttsv008.ctt.ne.jp ([210.166.4.137]:32640 "EHLO
	cttsv008.ctt.ne.jp") by vger.kernel.org with ESMTP
	id <S317359AbSGTERF> convert rfc822-to-8bit; Sat, 20 Jul 2002 00:17:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gabor Kerenyi <wom@tateyama.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/9] 2.5.6 lm_sensors
Date: Sat, 20 Jul 2002 13:11:16 +0900
User-Agent: KMail/1.4.2
References: <Pine.LNX.4.44.0207192224280.1120-100000@waste.org> <200207192308.54936.kelledin+LKML@skarpsey.dyndns.org>
In-Reply-To: <200207192308.54936.kelledin+LKML@skarpsey.dyndns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207201311.16996.wom@tateyama.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 July 2002 13:08, Kelledin wrote:
> > Anything short of "Destroy my precious Thinkpad? [y/N]"
> > probably is insufficient. Frankly, I don't think even that's
> > enough. Once this is mainlined, someone will want to build a
> > kitchen sink distro kernel with sensor support and if the code
> > itself isn't autodetecting whether it's on a problematic
> > platform, it won't be long before someone boots their Thinkpad
> > off a friend's CDR and toasts it.
>
> I agree, the lm_sensors driver should maintain a blacklist for
> ThinkPads, and make it possible to disable the blacklist only by
> going in and hacking the kernel source manually.  Whenever the
> lm_sensors drivers detect a blacklisted ThinkPad, they should
> vehemently refuse to function.

The blacklist thing is a good idea. Think for those who have been
just started learning linux. They don't know what an EXPERIMANTAL
status is. At my company there are only IBM ThinkPads and I hope
some of the users will try running Linux (my suggestion) and they
would be very upset if something went wrong.

Who is so crazy that he wants to try it he can still modify the
source.

Gabor

