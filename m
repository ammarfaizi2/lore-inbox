Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290965AbSBFXsu>; Wed, 6 Feb 2002 18:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290967AbSBFXsj>; Wed, 6 Feb 2002 18:48:39 -0500
Received: from [208.147.64.186] ([208.147.64.186]:27021 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S290965AbSBFXsY>; Wed, 6 Feb 2002 18:48:24 -0500
Date: Wed, 30 Jan 2002 00:20:53 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Robert Love <rml@tech9.net>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help in 2.5.3-pre6
In-Reply-To: <1012374707.3213.24.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0201300019590.10912-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well since the old config stuff was just broken it sounds like the perfect
time to put in the new stuff rather then wasting time fixing the old,
right ;-)

(ducks and runs for cover)

David Lang

 On 30 Jan 2002, Robert Love wrote:

> Date: 30 Jan 2002 02:11:16 -0500
> From: Robert Love <rml@tech9.net>
> To: Linus Torvalds <torvalds@transmeta.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Configure.help in 2.5.3-pre6
>
> On Wed, 2002-01-30 at 01:35, Linus Torvalds wrote:
>
> > I'd much _prefer_ to have somebody who knows menuconfug/xconfig (or just
> > wants to learn).  I have a totally untested patch for menuconfig, that
> > probably just works (like the regular config thing it doesn't actualy
> > take _advantage_ of pairing the Config.help files up with the questions,
> > but at least it should give you the help texts like it used to).
>
> Does not work for me; menuconfig bails out to the console (but does not
> return to prompt) on "?" ...
>
> I don't no one lick of this stuff either, so that is all you get from
> me. :)
>
> 	Robert Love
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
