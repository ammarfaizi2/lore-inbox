Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130149AbQKGMP0>; Tue, 7 Nov 2000 07:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129662AbQKGMPQ>; Tue, 7 Nov 2000 07:15:16 -0500
Received: from proxy.ovh.net ([213.244.20.42]:36369 "HELO proxy.ovh.net")
	by vger.kernel.org with SMTP id <S129355AbQKGMPH>;
	Tue, 7 Nov 2000 07:15:07 -0500
Message-ID: <3A07F234.80AB1D06@ovh.net>
Date: Tue, 07 Nov 2000 13:14:44 +0100
From: octave klaba <oles@ovh.net>
X-Mailer: Mozilla 4.73 [en] (Win98; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: "Magnus Naeslund(b)" <mag@bahnhof.se>
Cc: Matthew Sanderson <matthew@DaMOO.csun.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.17: do_try_to_free_pages fails, no OOM
In-Reply-To: <Pine.LNX.3.96.1001106235858.875A-100000@DaMOO.csun.edu> <009001c048ab$7d1a7fb0$020a0a0a@totalmef>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oct 24 00:07:39 gimme kernel: VM: do_try_to_free_pages failed for
> postmaster...

2.2.18pre19 should fix this problem if andrea's patch is inside.
if not, you have to patch pre18 with VM-global-2.2.18pre18-7.bz2
if you are from europe you can downlaod it from:
ftp://ftp.ovh.net/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre18/VM-global-2.2.18pre18-7.bz2

Octave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
