Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268022AbRHPVK2>; Thu, 16 Aug 2001 17:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268691AbRHPVKT>; Thu, 16 Aug 2001 17:10:19 -0400
Received: from anime.net ([63.172.78.150]:43793 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S268022AbRHPVKM>;
	Thu, 16 Aug 2001 17:10:12 -0400
Date: Thu, 16 Aug 2001 14:09:59 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Bob Martin <bmartin@ayrix.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Via chipset
In-Reply-To: <3B7BE84D.117212FE@ayrix.net>
Message-ID: <Pine.LNX.4.30.0108161406270.15558-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, Bob Martin wrote:
> I have a MSI-6195 slot-A , AMD chipset with a visiontek nvidia vanta 32mb agp
> [...]
> related or not, probably not. I suspect xscreensaver is triggering something in
> the xserver that is not normally getting hit in normal use.

Its probably the vanta.

xscreensaver is most likely starting one of the GL screensavers.

xfree86 opengl does not like the vanta on any of my systems -- intel or
amd. it locks up after ~10-15 sec of running a gl app.

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

