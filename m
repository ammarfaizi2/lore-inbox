Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130523AbRCTRho>; Tue, 20 Mar 2001 12:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130531AbRCTRhe>; Tue, 20 Mar 2001 12:37:34 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:40441 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S130523AbRCTRhU>;
	Tue, 20 Mar 2001 12:37:20 -0500
Date: Tue, 20 Mar 2001 18:35:38 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Peter Lund <firefly@netgroup.dk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: esound (esd), 2.4.[12] chopped up sound
In-Reply-To: <3AB5F86E.69B3593C@netgroup.dk>
Message-ID: <Pine.GSO.4.30.0103201832260.15849-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On my home machine playing sound through esd has worked beautifully on various
> kernels from 2.2.5 and up to 2.2.18.
> On 2.4.1 and 2.4.2 it stinks.
>
> It sounds like there are small pauses or repetitions in the sound, as if esd
> doesn't get
> the data quickly enough from the client or something.  Music and voices
> (realaudio radio) still easy to understand but it does get on my nerves after a
> few minutes :(

Are you sure that the problem isn't at the mp3->raw conversino point? In
mandrake for example, mpg123 is badly compiled, and plays nicely on 2.2,
but awfully on 2.4.
I suggest you trying another (meybe self-compiled) version of mpg123.

bye,
Balazs Pozsar.

