Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280228AbRKIWMj>; Fri, 9 Nov 2001 17:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280233AbRKIWMa>; Fri, 9 Nov 2001 17:12:30 -0500
Received: from anime.net ([63.172.78.150]:16912 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S280228AbRKIWMZ>;
	Fri, 9 Nov 2001 17:12:25 -0500
Date: Fri, 9 Nov 2001 14:12:13 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Rick Gaudette <Richard.Gaudette@Colorado.EDU>,
        <linux-kernel@vger.kernel.org>
Subject: Re: X-Windows locks up under concurrent OpenGL (Mesa) and I
In-Reply-To: <8B83CB50455@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.30.0111091410490.1774-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001, Petr Vandrovec wrote:
> Help is simple - do not use VIA chipsets, at least I did not found any
> other way how to get it to work (except disabling mainmemory,PCI->AGP
> transfers (CPU->AGP are OK, obviously...)).

  ABIT KG-7-RAID
  Tyan Tiger MP (S2460)

These are not VIA chipsets... but he described the same hangs anyway.
So, it appears some other explanation is needed than "it's a VIA bug".

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

