Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131821AbQKAXat>; Wed, 1 Nov 2000 18:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131811AbQKAXaj>; Wed, 1 Nov 2000 18:30:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19752 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131861AbQKAXa1>; Wed, 1 Nov 2000 18:30:27 -0500
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
To: trini@kernel.crashing.org (Tom Rini)
Date: Wed, 1 Nov 2000 23:30:50 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), garloff@suse.de, jamagallon@able.es,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001101162108.C32641@opus.bloom.county> from "Tom Rini" at Nov 01, 2000 04:21:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13r7LH-0000z2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, but what's more important is that all of these "kgcc" variants are
> gcc 2.7.2.x-based (unless there's one I don't know about).  And we don't want
> 2.7.2.x, we want egcs 1.1.2 or newer (but not gcc 2.9x, unless you know what
> you're doing and are trying to fix the compiler. :)).

Conectiva kgcc is egcs 1.1.2
Red Hat kgcc is egcs 1.1.2
Mandrake kgcc I believe is egcs 1.1.2

Debian gcc272 is gcc272

So the subset checking for kgcc is fine

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
