Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279641AbRJXWmO>; Wed, 24 Oct 2001 18:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279639AbRJXWmF>; Wed, 24 Oct 2001 18:42:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62986 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279633AbRJXWlv>; Wed, 24 Oct 2001 18:41:51 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 24 Oct 2001 23:48:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        benh@kernel.crashing.org (Benjamin Herrenschmidt),
        linux-kernel@vger.kernel.org, mochel@osdl.org (Patrick Mochel),
        jlundell@pobox.com (Jonathan Lundell)
In-Reply-To: <Pine.LNX.4.33.0110240915590.8049-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 24, 2001 09:19:45 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wWok-0002wN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you want to synchronize your raid thing, make the user-level thing that
> triggers the suspend do it. Same goes for things like "sync network
> filesystems" etc. This is not a kernel level issue, and the kernel
> shouldn't even try to do it.

Makes good sense - I agree
