Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278124AbRJWRln>; Tue, 23 Oct 2001 13:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278125AbRJWRld>; Tue, 23 Oct 2001 13:41:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29188 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278124AbRJWRlY>; Tue, 23 Oct 2001 13:41:24 -0400
Subject: Re: [PATCH] BOOTP Standalone Floppy Boot (2.4.13pre6)
To: ast@domdv.de (Andreas Steinmetz)
Date: Tue, 23 Oct 2001 18:48:18 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20011023132050.ast@domdv.de> from "Andreas Steinmetz" at Oct 23, 2001 01:20:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15w5f0-0000SA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If using 2.4.x standalone floppy boot (i.e. dd if=vmlinuz of=/dev/fd0, then
> booting from this floppy) with a BOOTP/NFS root enabled kernel fails. This
> behaviour is different from 2.2.x. 2.4.x uses:

Standalone floppy boot is purely historic interest, and likely to go away
Stick lilo or similar on the floppy
