Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282453AbRLUXOO>; Fri, 21 Dec 2001 18:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283924AbRLUXOE>; Fri, 21 Dec 2001 18:14:04 -0500
Received: from datela-1-3-122.dialup.vol.cz ([212.20.98.12]:27407 "HELO
	ghost.ucw.cz") by vger.kernel.org with SMTP id <S282453AbRLUXNq>;
	Fri, 21 Dec 2001 18:13:46 -0500
Date: Sat, 22 Dec 2001 01:14:11 +0100 (MET)
From: <brain@artax.karlin.mff.cuni.cz>
To: Andrey Panin <pazke@orbita1.ru>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problems with GUS PnP: ad1848, pnp
In-Reply-To: <20011222123216.A2283@pazke.ipt>
Message-ID: <Pine.LNX.4.30.0112220109270.12320-100000@ghost.ucw.cz>
X-Echelon: GRU Vatutinki Chodynka Khodinka Putin Suvorov USA Aquarium Russia Ladygin Lybia China Moscow missile reconnaissance agent spetsnaz security tactical target operation military nuclear force defense spy attack bomb explode tap MI5 IRS KGB CIA FBI NSA AK-47 MOSSAD M16 plutonium smuggle intercept plan intelligence war analysis president
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001, Andrey Panin wrote:

> Does the attached patch help you ?

Thanx. Now the ad1848 is able to detect the card. Ad1848 info about the card
corresponds with /proc/isapnp (io, irq, dma). But the DMA/IRQ conflict persists.

Brain

--------------------------------
Petr `Brain' Kulhavy
<brain@artax.karlin.mff.cuni.cz>
http://artax.karlin.mff.cuni.cz/~brain
Faculty of Mathematics and Physics, Charles University Prague, Czech Republic

---
Wedding is destiny, and hanging likewise.
                -- John Heywood

