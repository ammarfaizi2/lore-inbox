Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131159AbQK1VjN>; Tue, 28 Nov 2000 16:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131027AbQK1Vix>; Tue, 28 Nov 2000 16:38:53 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:43525
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S131004AbQK1Vin>; Tue, 28 Nov 2000 16:38:43 -0500
Date: Sat, 25 Nov 2000 23:08:14 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Patch: 2.4.0-test11ac4 version of pci and isapnp device ID's
 patch
In-Reply-To: <20001125225032.A5448@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.10.10011252307330.10729-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2000, Adam J. Richter wrote:

> 	For those of you playing with Alan Cox's linux-2.4.0-test11ac4
> release, I have made a separate patch of the remaining device ID
> changes which patches against that kernel and builds cleanly (the
> primary difference is that it omits the files that have gained the
> same ID tables in Alan's ac4 release).  The patch is FTPable from:
> 
> ftp://ftp.yggdrasil.com/pub/dist/device_control/kernel/pci_id_tables-2.4.0-test11-ac4.patch4.gz 

Hey Alan, are we now sorting sub-id's?

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
