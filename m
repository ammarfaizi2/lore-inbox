Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277024AbRKNUBE>; Wed, 14 Nov 2001 15:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277112AbRKNUAy>; Wed, 14 Nov 2001 15:00:54 -0500
Received: from anime.net ([63.172.78.150]:34063 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S277024AbRKNUAj>;
	Wed, 14 Nov 2001 15:00:39 -0500
Date: Wed, 14 Nov 2001 11:59:09 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
cc: Lars Magne Ingebrigtsen <larsi@gnus.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
In-Reply-To: <Pine.GSO.4.33.0111141533320.14971-100000@gurney>
Message-ID: <Pine.LNX.4.30.0111141158230.24024-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2001, Alastair Stevens wrote:
> But the key question is still this: is this purely a hardware issue? My
> understanding is that with recent 2.4 kernels, Athlon optimisations and
> AMD 760 issues are sorted - am I right?

The 'athlon optimizations' is a VIA KT133A bug, afaik AMD760MP is immune
(at least my tests indicate it is)

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

