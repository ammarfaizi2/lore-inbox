Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131227AbQLLAGw>; Mon, 11 Dec 2000 19:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbQLLAGm>; Mon, 11 Dec 2000 19:06:42 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:63879 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S129908AbQLLAG3>; Mon, 11 Dec 2000 19:06:29 -0500
Date: Mon, 11 Dec 2000 01:25:48 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: Andrew Stubbs <andrews@stusoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Enviromental Monitoring
In-Reply-To: <3A33B81F.FAF661FB@haque.net>
Message-ID: <Pine.LNX.4.30.0012110119390.9761-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000, Mohammad A. Haque wrote:

> Hit http://www.lm-sensors.nu/

do these guys /ever/ plan on submitting kernel patches? i used to use
lm_sensors on 2.2 cause it was fairly painless - but just havn't
bothered with 2.4 cause it was a pita when i tried.

i know they talked AC at some point about getting a patch in, but
nothing seems to have come from it.

what a damm damm shame. we've got code that appears to work really
well[1] to drive most of the hardware sensors out there - but the
code is used by only a tiny fraction of linux users cause these guys
/apparently/ would much rather keep themselves and their code
isolated in some god forsaken CVS server rather than submit their
code to Linus.

fscking shame.

-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
Ten persons who speak make more noise than ten thousand who are silent.
		-- Napoleon I

[1]. i only had very slight problems with module ref counts earlier
in its devel cycle.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
