Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbTAEHhC>; Sun, 5 Jan 2003 02:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbTAEHhC>; Sun, 5 Jan 2003 02:37:02 -0500
Received: from mail2.scram.de ([195.226.127.112]:65288 "EHLO mail2.scram.de")
	by vger.kernel.org with ESMTP id <S263326AbTAEHhB>;
	Sun, 5 Jan 2003 02:37:01 -0500
Date: Sun, 5 Jan 2003 08:42:59 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Matthias Andree <matthias.andree@gmx.de>
cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       Andreas Dilger <adilger@turbolabs.com>, Larry McVoy <lm@bitmover.com>
Subject: Re: Documentation/BK-usage/bksend problems?
In-Reply-To: <20030105015444.GE29511@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.44.0301050839340.19683-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> The changes are fine, for 1.838 and 1.839, but the patch itself only
> contains the effects of 1.839. The attached gzip_uu wrapped bk
> "receive"able stuff is fine again and contains both ChangeSets.
>
> It seems as though it would take "diff 1.839 against 1.838" for bk gnupatch
> and "changesets 1.838 to 1.839 inclusively" for bk send.

I noticed the same when sending my Token Ring updates. Here i tried to
send 4 changesets and only the second one ended up in the patch while the
bk send part was OK. This was on Alpha, so i don't think it's arch
dependent.

Cheers,
--jochen


