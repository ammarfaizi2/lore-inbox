Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272418AbRH3TTJ>; Thu, 30 Aug 2001 15:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272419AbRH3TS7>; Thu, 30 Aug 2001 15:18:59 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30994 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272418AbRH3TSq>; Thu, 30 Aug 2001 15:18:46 -0400
Subject: Re: [PATCH] blkgetsize64 ioctl
To: michael_e_brown@dell.com
Date: Thu, 30 Aug 2001 20:18:06 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), tytso@mit.edu, bcrl@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108301403280.1213-200000@blap.linuxdev.us.dell.com> from "Michael E Brown" at Aug 30, 2001 02:10:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cXKI-0001eF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan,
> 	Here is a patch that reserves the 108 and 109 ioctl numbers for
> get/set last sector. This patch has already been merged into the ia64
> tree, and is currently necessary in order to support the EFI GPT
> partitioning scheme on ia64. It is also in the Red Hat kernel tree. I had
> assumed that somebody at Red Hat would have forwarded it to you.

Rejected. I still think this is an ugly evil hack and want no part in it.
Its definitely not a 2.4 core tree thing.

Alan
