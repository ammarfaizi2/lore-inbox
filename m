Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbREOWXI>; Tue, 15 May 2001 18:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbREOWW6>; Tue, 15 May 2001 18:22:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28677 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261644AbREOWWq>; Tue, 15 May 2001 18:22:46 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: viro@math.psu.edu (Alexander Viro)
Date: Tue, 15 May 2001 23:18:02 +0100 (BST)
Cc: chip@valinux.com (Chip Salzenberg),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.GSO.4.21.0105151746320.22958-100000@weyl.math.psu.edu> from "Alexander Viro" at May 15, 2001 05:46:56 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zn8l-0003D5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Type of filesystem where the file came from? Sure.

Who says it comes from only one - even on devfs that is not true

/dev/disk/4 is quite possibly

	disk
	scsi-disk
	scsi-device
	usb-scsi-device
	usb-device

all at once

