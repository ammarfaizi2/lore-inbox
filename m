Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287289AbSAXLEy>; Thu, 24 Jan 2002 06:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287317AbSAXLEo>; Thu, 24 Jan 2002 06:04:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:23723 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287289AbSAXLEl>;
	Thu, 24 Jan 2002 06:04:41 -0500
Date: Thu, 24 Jan 2002 14:02:10 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: zdenek <zdenek@smetana.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Missing changelog to Ingo's J5 scheduler?
In-Reply-To: <20020124.115653.730556705.rene.rebe@gmx.net>
Message-ID: <Pine.LNX.4.33.0201241401090.8884-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Jan 2002, Rene Rebe wrote:

> Ok. After some massive rebooting:
>
> -J2 is worser. starting XFree(+gnome) when three gcc's are running
> take long (> half a minute?). With -J5 X start nearly normal (mostly
> file access time anyway?) Dragging windows arround is nearly equal.
> Although with -J2 i sometimes noticed a really big latency when
> starting vim or man ...

thanks, so -J5 is an improvement on all fronts - good.

> Oh. btw. The -J5 was tested with 2.4.18-pre7; the rest was with
> vanilla-2.4.17 - I hope this doesn't make a performance difference for
> this tests ...

i dont think there is a difference, as long as you have enough RAM and
dont swap usually.

	Ingo

