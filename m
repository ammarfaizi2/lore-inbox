Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbRG1GTA>; Sat, 28 Jul 2001 02:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266428AbRG1GSv>; Sat, 28 Jul 2001 02:18:51 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:18705 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S266417AbRG1GSf>; Sat, 28 Jul 2001 02:18:35 -0400
From: bvermeul@devel.blackstar.nl
Date: Sat, 28 Jul 2001 08:21:24 +0200 (CEST)
To: Jussi Laako <jlaako@pp.htv.fi>
cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <3B61C16F.AD4A1B24@pp.htv.fi>
Message-ID: <Pine.LNX.4.33.0107280820540.23742-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001, Jussi Laako wrote:

> bvermeul@devel.blackstar.nl wrote:
> >
> > Possibly. We're talking 130 kByte in total. The above is the reason why
> > I don't like using reiserfs on my development system. My files get
> > completely garbled, with the data randomly distributed over the files
>
> How about using notail -option?

Never tried it. I'll see if I can reproduce.

Bas Vermeulen
-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

