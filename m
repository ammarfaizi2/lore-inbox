Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278152AbRJWR6d>; Tue, 23 Oct 2001 13:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278151AbRJWR6X>; Tue, 23 Oct 2001 13:58:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47364 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278149AbRJWR6Q>; Tue, 23 Oct 2001 13:58:16 -0400
Subject: Re: [Lse-tech] Re: Preliminary results of using multiblock raw I/O
To: axboe@suse.de (Jens Axboe)
Date: Tue, 23 Oct 2001 19:04:44 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), nagar@us.ibm.com (Shailabh Nagar),
        baettig@scs.ch (Reto Baettig), lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011023194935.A12005@suse.de> from "Jens Axboe" at Oct 23, 2001 07:49:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15w5uu-0000VU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fine with me, the major reason for doing 255 sectors and not 256 was IDE
> of course... So feel free to change the default host max_sectors to 256.

The -ac tree uses 128 for IDE currently I believe. I will double check
before I tweak anything
