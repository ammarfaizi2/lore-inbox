Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131240AbQLJRsV>; Sun, 10 Dec 2000 12:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131518AbQLJRsL>; Sun, 10 Dec 2000 12:48:11 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:61447
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131240AbQLJRsF>; Sun, 10 Dec 2000 12:48:05 -0500
Date: Sun, 10 Dec 2000 09:17:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Hakan Lennestal <hakanl@cdt.luth.se>
cc: gsharp@ihug.co.nz, linux-kernel@vger.kernel.org
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11 
In-Reply-To: <20001210121512.A08BD418A@tuttifrutti.cdt.luth.se>
Message-ID: <Pine.LNX.4.10.10012100916360.8764-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000, Hakan Lennestal wrote:

> The problem being that the kernel hangs after a dma timeout in the
> partition detection phase during bootup for speeds higher than udma 44.
> This is an IBM-DTLA-307030 connected to a hpt366 pci card on a BH6
> motherboard.

Well try the latest out there...test12-pre7.

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
