Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264411AbRFSQrk>; Tue, 19 Jun 2001 12:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264415AbRFSQrV>; Tue, 19 Jun 2001 12:47:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5904 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264411AbRFSQrR>; Tue, 19 Jun 2001 12:47:17 -0400
Subject: Re: 2.2.10-pre4, error while applying the patch
To: jean-luc.coulon@wanadoo.fr (Jean-Luc Coulon)
Date: Tue, 19 Jun 2001 17:46:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B2F7D30.4DE87953@wanadoo.fr> from "Jean-Luc Coulon" at Jun 19, 2001 06:26:24 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15COe6-0006FL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> patching file `drivers/scsi/sym53c8xx_defs.h'
> The next patch would create the file `drivers/sound/ad1848.c',
> which already exists!  Assume -R? [n]

My error - just skip the ad1848.c segment
