Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbQLLAnn>; Mon, 11 Dec 2000 19:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131387AbQLLAne>; Mon, 11 Dec 2000 19:43:34 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:17288 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S131386AbQLLAn1>; Mon, 11 Dec 2000 19:43:27 -0500
Date: Tue, 12 Dec 2000 00:16:06 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Mohammad A. Haque" <mhaque@haque.net>,
        Andrew Stubbs <andrews@stusoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Enviromental Monitoring
In-Reply-To: <E145ctB-0000Ln-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0012120009520.20500-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2000, Alan Cox wrote:

> Its in 2.4 it wont be in 2.2 I suspect

it is? i don't see the sensors stuff, so you must mean just the i2c
bits. Any word on whether we'll see sensors code go in to 2.4?

like i said, their code has worked well for me, but they seem intent
on keeping it as obscure as possible... (i remember someone posted to
l-k that they'd started a sensors project, and had code for the LM80.
he wasn't at all aware of lm_sensors!).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
Some programming languages manage to absorb change, but withstand progress.
		-- Epigrams in Programming, ACM SIGPLAN Sept. 1982

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
