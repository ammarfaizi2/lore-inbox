Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130524AbQLTVpg>; Wed, 20 Dec 2000 16:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbQLTVp0>; Wed, 20 Dec 2000 16:45:26 -0500
Received: from uucp.nl.uu.net ([193.79.237.146]:41097 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S130524AbQLTVpX>;
	Wed, 20 Dec 2000 16:45:23 -0500
Date: Wed, 20 Dec 2000 21:58:58 +0100 (CET)
From: kees <kees@schoen.nl>
To: "Andreas M. Kirchwitz" <amk@krell.snafu.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix emu10k1 init breakage in 2.2.18
In-Reply-To: <slrn93vb44.enh.amk@krell.zikzak.de>
Message-ID: <Pine.LNX.4.21.0012202157160.1033-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patch indeed solves the problem with EMU10K. It now works well except
from the fact that the trebble and bass controls still have been vanished.

Thanks for the patch.

Kees

BTW could it be something simular for es1371?. This also fails with 2.2.18

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
