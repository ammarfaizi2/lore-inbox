Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283328AbRLDTgn>; Tue, 4 Dec 2001 14:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283303AbRLDTfN>; Tue, 4 Dec 2001 14:35:13 -0500
Received: from anime.net ([63.172.78.150]:35234 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S283295AbRLDTe2>;
	Tue, 4 Dec 2001 14:34:28 -0500
Date: Tue, 4 Dec 2001 11:34:16 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "M. Edward Borasky" <znmeb@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <E16BBsg-0001Ny-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0112041130580.14323-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001, Alan Cox wrote:
> > What I'm trying to establish here is that if ALSA is to become the
> > main-stream Linux sound driver set, it's going to need to support -- *fully*
> > support -- the top-of-the-line sound cards like my M-Audio Delta 66. It
> Not really. The number of people who actually care about such cards is close
> to nil. What matters is that the API can cleanly express what the Delta66
> can do, and that you can write a driver for it under ALSA without hacking up
> the ALSA core.
> I'm happy both of those are true.

ALSA has supported ice1712 chipset for some time now.

BTW Delta 66 isnt top of the line -- Delta 1010 is. And ALSA supports it
too.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

