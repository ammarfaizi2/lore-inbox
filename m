Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129697AbQKYC77>; Fri, 24 Nov 2000 21:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129492AbQKYC7t>; Fri, 24 Nov 2000 21:59:49 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:53007
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S129153AbQKYC7c>; Fri, 24 Nov 2000 21:59:32 -0500
Date: Fri, 24 Nov 2000 18:29:20 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: PIIX4 BX Errata for DMA errors.
Message-ID: <Pine.LNX.4.10.10011241823350.7446-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anyone having DMA errors that are dmaproc: error 14, there is not a clean
workaround yet.  Also the Intel erratas state that only a bus reset will
clear the hang, but the details are loose.

Regards,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
