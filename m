Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271629AbRHZX7f>; Sun, 26 Aug 2001 19:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271628AbRHZX7Z>; Sun, 26 Aug 2001 19:59:25 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20242 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271630AbRHZX7L>; Sun, 26 Aug 2001 19:59:11 -0400
Subject: Re: Linux 2.4.8-ac12 not all there
To: hugh@veritas.com (Hugh Dickins)
Date: Mon, 27 Aug 2001 01:02:33 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108270035470.9341-100000@localhost.localdomain> from "Hugh Dickins" at Aug 27, 2001 12:55:31 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15b9rN-00031k-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the ac12 mm/memory.c same as ac11 version.  Perhaps that patch
> collided with more general 2.4.9 merge and ended up reversing.
> Patch below against 2.4.8-ac11 applies equally to 2.4.8-ac12.

Looks like the evil revert monster got them. Thanks
