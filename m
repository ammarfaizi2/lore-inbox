Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129931AbRBKUWc>; Sun, 11 Feb 2001 15:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130006AbRBKUWW>; Sun, 11 Feb 2001 15:22:22 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:22538 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129931AbRBKUWM>;
	Sun, 11 Feb 2001 15:22:12 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102112021.XAA15811@ms2.inr.ac.ru>
Subject: Re: BUG: SO_LINGER + shutdown() does not block?
To: chris@scary.BEasts.ORG (Chris Evans)
Date: Sun, 11 Feb 2001 23:21:59 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0102111835060.10619-100000@ferret.lmh.ox.ac.uk> from "Chris Evans" at Feb 11, 1 09:45:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I'm not seeing shutdown(2) block on a TCP socket. This is Linux kernel
> 2.2.16 (RH7.0). Is this a kernel bug, a documentation bug,

Man page is wrong.

What's about kernel... Hmm, actually, it is worth to test genuine bsd.
Such feature could be useful.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
