Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266529AbRGRA7u>; Tue, 17 Jul 2001 20:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbRGRA7k>; Tue, 17 Jul 2001 20:59:40 -0400
Received: from anime.net ([63.172.78.150]:34055 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S266529AbRGRA7Y>;
	Tue, 17 Jul 2001 20:59:24 -0400
Date: Tue, 17 Jul 2001 17:58:52 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Jussi Laako <jlaako@pp.htv.fi>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
In-Reply-To: <3B53221B.28B8D5A1@pp.htv.fi>
Message-ID: <Pine.LNX.4.30.0107171758050.8824-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2001, Jussi Laako wrote:
> Daniel Phillips wrote:
> > We are not that far away from being able to handle 8K blocks, so that
> > would bump it up to 32 TB.
> That's way too small. Something like 32 PB would be better... ;)
> We need at least one extra bit in volume/file size every year.

volume size grows faster than file size, doesn't it? maybe extra bit of
volume and 1/2 bit file size per year...

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

