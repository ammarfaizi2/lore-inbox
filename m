Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272672AbRIUTNL>; Fri, 21 Sep 2001 15:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274785AbRIUTNB>; Fri, 21 Sep 2001 15:13:01 -0400
Received: from anime.net ([63.172.78.150]:35856 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S272672AbRIUTMs>;
	Fri, 21 Sep 2001 15:12:48 -0400
Date: Fri, 21 Sep 2001 12:13:07 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: bill davidsen <davidsen@tmr.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <200109211722.f8LHMKI04360@deathstar.prodigy.com>
Message-ID: <Pine.LNX.4.30.0109211211400.2762-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, bill davidsen wrote:
> We know one thing it's doing, keeping user programs from causing errors.
> If the error didn't occur in user mode I would be more careful, but
> having been shown that it does, I will use the fix. Since the older BIOS
> versions set it the other way, I'm willing to assume it's safe and move
> forward.

VIA's own KT133A chipset drivers dont seem to fiddle the bit though...
On other VIA drivers eg MVP3 etc they DO fiddle bits.

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

