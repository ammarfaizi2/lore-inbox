Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287966AbSABUzp>; Wed, 2 Jan 2002 15:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287985AbSABUzf>; Wed, 2 Jan 2002 15:55:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43021 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286999AbSABUyQ>; Wed, 2 Jan 2002 15:54:16 -0500
Subject: Re: SCSI host numbers?
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Wed, 2 Jan 2002 21:01:57 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), nahshon@actcom.co.il,
        linux-kernel@vger.kernel.org
In-Reply-To: <200201021931.g02JV1R27294@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at Jan 02, 2002 12:31:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LsWL-0005Rg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Comments? Got a suggestion for which file the generic function should
> go into? I figure on stripping the leading "devfs_" part of the
> function names.

Sounds sensible to me. I guess it belongs in lib/ somewhere ?
