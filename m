Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285207AbRLSKZz>; Wed, 19 Dec 2001 05:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285227AbRLSKZp>; Wed, 19 Dec 2001 05:25:45 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:3332 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285207AbRLSKZ0>; Wed, 19 Dec 2001 05:25:26 -0500
Date: Wed, 19 Dec 2001 11:25:22 +0100 (CET)
From: Petr Kulhavy <brain@artax.karlin.mff.cuni.cz>
To: Andrey Panin <pazke@orbita1.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with GUS PnP: ad1848, pnp
In-Reply-To: <20011220104657.A195@pazke.ipt>
Message-ID: <Pine.LNX.3.96.1011219111521.11868A-100000@artax.karlin.mff.cuni.cz>
X-Echelon: GRU Vatutinki Aquarium Khodynka Chodynka Khodinka Putin Suvorov USA Russia Ladygin China Moscow missile reconnaissance agent spetsnaz security tactical target operation military defense spy information attack bomb explode tap intercept plan intelligence war analysis echelon sucks
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2001, Andrey Panin wrote:

> First, don't mix isapnptools and kernel level ISAPNP support.

Why? Both should set card parameters, shouldn't they? And when one sets
parameters, the second should be able to read them (and read the same
values).

> Second, send a copy of /proc/isapnp to lkml, may be we can add isapnp
> support for your card.

OK. But how do I learn if my card is supported or not?

Brain

--------------------------------
Petr `Brain' Kulhavy
<brain@artax.karlin.mff.cuni.cz>
http://artax.karlin.mff.cuni.cz/~brain
Faculty of Mathematics and Physics, Charles University Prague, Czech Republic

---
Never eat anything bigger than your head.

