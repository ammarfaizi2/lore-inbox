Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131065AbQKLQDn>; Sun, 12 Nov 2000 11:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131102AbQKLQDY>; Sun, 12 Nov 2000 11:03:24 -0500
Received: from quechua.inka.de ([212.227.14.2]:11602 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131065AbQKLQDO>;
	Sun, 12 Nov 2000 11:03:14 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Where is it written?
In-Reply-To: <20001110184031.A2704@munchkin.spectacle-pond.org> <200011110011.eAB0BbF244111@saturn.cs.uml.edu> <20001110192751.A2766@munchkin.spectacle-pond.org> <20001111163204.B6367@inspiron.suse.de> <20001111171749.A32100@wire.cadcamlab.org>
Organization: private Linux site, southern Germany
Date: Sun, 12 Nov 2000 16:35:59 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E13uzAl-0004hs-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well it's safer if you are lazy about prototyping varargs functions.
> But of course by doing that you're treading on thin ice anyway, in
> terms of type promotion and portability.  So I guess it's much better
> to say "varargs functions MUST be prototyped" and use the registers.

make -Wmissing-prototypes mandatory :-)

Olaf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
