Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267129AbTA1Csz>; Mon, 27 Jan 2003 21:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267319AbTA1Csz>; Mon, 27 Jan 2003 21:48:55 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:35485 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S267129AbTA1Csz>;
	Mon, 27 Jan 2003 21:48:55 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200301280257.FAA27287@sex.inr.ac.ru>
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
To: davem@redhat.com (David S. Miller)
Date: Tue, 28 Jan 2003 05:57:55 +0300 (MSK)
Cc: andersg@0x63.nu, lkernel2003@tuxers.net, linux-kernel@vger.kernel.org,
       tobi@tobi.nu
In-Reply-To: <20030127.143625.84825692.davem@redhat.com> from "David S. Miller" at Jan 27, 3 02:36:25 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Alexey, this piece of code was buggy first time it was coded, and it
> may still have some holes. :-)))

To my shame, I cannot say "no". It was written sort of too fast. :-)

Did the reporters see packets with wrong checksum on wire or wrong tcp
headers or something like that?

Alexey
