Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263927AbRGNRCb>; Sat, 14 Jul 2001 13:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264096AbRGNRCV>; Sat, 14 Jul 2001 13:02:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2573 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263927AbRGNRCI>; Sat, 14 Jul 2001 13:02:08 -0400
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
To: cw@f00f.org (Chris Wedgwood)
Date: Sat, 14 Jul 2001 18:02:22 +0100 (BST)
Cc: dwmw2@infradead.org (David Woodhouse), hch@caldera.de (Christoph Hellwig),
        Gunther.Mayer@t-online.de (Gunther Mayer), paul@paulbristow.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20010715045842.B6963@weta.f00f.org> from "Chris Wedgwood" at Jul 15, 2001 04:58:42 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LSoA-0001Sj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyhow, say we leave linux/malloc.h for external module authors, but
> make the other changes?

At most for 2.4 but a #warning  in it

> I'll re-run the script I wrote duing 2.5.x when we do remove malloc.h
> to catch anything left over.

Yep

