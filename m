Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135805AbRDTRv0>; Fri, 20 Apr 2001 13:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135852AbRDTRvA>; Fri, 20 Apr 2001 13:51:00 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:7692 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135904AbRDTRu0>; Fri, 20 Apr 2001 13:50:26 -0400
Date: Fri, 20 Apr 2001 10:49:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mark Kettenis <kettenis@science.uva.nl>
cc: <linux-kernel@vger.kernel.org>, <wichert@cistron.nl>,
        <ebrunet@quatramaran.ens.fr>
Subject: Re: Children first in fork
In-Reply-To: <200104201456.f3KEuor01481@debye.wins.uva.nl>
Message-ID: <Pine.LNX.4.31.0104201049030.5523-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Apr 2001, Mark Kettenis wrote:
>		 I believe the 2.2.x behaviour was pretty much
> useless,

No. 2.2.x is not useless, it is apparently _buggy_ in this regard. Some of
the fixes in the 2.3.x timeframe seem to not have made it into 2.2.x.

		Linus

