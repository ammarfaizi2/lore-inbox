Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129678AbQKHA5e>; Tue, 7 Nov 2000 19:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131112AbQKHA5Y>; Tue, 7 Nov 2000 19:57:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44056 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129678AbQKHA5K>; Tue, 7 Nov 2000 19:57:10 -0500
Subject: Re: Installing kernel 2.4
To: jmerkey@timpanogas.org (Jeff V. Merkey)
Date: Wed, 8 Nov 2000 00:54:16 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), kernel@kvack.org,
        gandalf@wlug.westbo.se (Martin Josefsson),
        tigran@veritas.com (Tigran Aivazian), anils_r@yahoo.com (Anil kumar),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A0897F5.563552AD@timpanogas.org> from "Jeff V. Merkey" at Nov 07, 2000 05:01:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13tJVJ-00080L-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We need a format that allow multiple executable segments to be combined
> in a single executable and the loader have enough smarts to grab the
> right one based on architecture.  two options:

ELF can do that just fine


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
