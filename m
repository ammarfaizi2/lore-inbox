Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312375AbSDCT1o>; Wed, 3 Apr 2002 14:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312363AbSDCT1a>; Wed, 3 Apr 2002 14:27:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51722 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312374AbSDCT0c>; Wed, 3 Apr 2002 14:26:32 -0500
Date: Wed, 3 Apr 2002 11:25:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <E16sqaK-0004MO-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0204031125060.3004-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Apr 2002, Alan Cox wrote:
>
> > The fact that the code was back-ported from 2.5.x and that the _GPL still 
> > is there too is just a mistake, partly because I've not gotten any updates 
> > from Ingo..
> 
> So Linus is allowed to arbitarily export other peoples contributions ?

Those "other people" _are_ me and Ingo, in fact.

And yes, I damn well have the right to abritrarily export my own 
contributions, thank you very much.

		Linus

