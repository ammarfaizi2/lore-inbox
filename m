Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284833AbRLKCCy>; Mon, 10 Dec 2001 21:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284819AbRLKCCo>; Mon, 10 Dec 2001 21:02:44 -0500
Received: from mtiwmhc26.worldnet.att.net ([204.127.131.51]:21501 "EHLO
	mtiwmhc26.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S284814AbRLKCCd>; Mon, 10 Dec 2001 21:02:33 -0500
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
From: Cory Bell <cory.bell@usa.net>
To: John Clemens <john@deater.net>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112101240180.15280-100000@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.33.0112101240180.15280-100000@pianoman.cluster.toy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 10 Dec 2001 17:53:03 -0800
Message-Id: <1008035585.17062.22.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-10 at 09:53, John Clemens wrote:
> My apologies, i misunderstood what you were saying before..  As an
> additional data point, one person who tried my origional USB hack (moving
> it to IRQ 11) also reported possible problems with PCMCIA not working
> anymore... this isn't my experience however.  Also note that the Trident
> BladeXP is also on IRQ11, not that linux should care.

PCMCIA (16-bit, not cardbus) ethernet/modem (only tried the modem) works
fine for me with the patch. Haven't tried cardbus or multiple cards.

> Also, I'm running BIOS rev GD1.08 (it shipped with GD1.03, and i tried
> GD1.06 when it came out).. what is everyone else running?

1.03 (latest available).

-Cory

