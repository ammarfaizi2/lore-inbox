Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274275AbRISXj3>; Wed, 19 Sep 2001 19:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274274AbRISXjT>; Wed, 19 Sep 2001 19:39:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64006 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269693AbRISXjE>; Wed, 19 Sep 2001 19:39:04 -0400
Subject: Re: PROBLEM: [1.] X session randomly crashes because of kernel problem.
To: stephane.brossier@sun.com (Stephane Brossier)
Date: Thu, 20 Sep 2001 00:44:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3BA929C7.B6B6000A@sun.com> from "Stephane Brossier" at Sep 19, 2001 04:27:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jr0u-0004Dd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sep 19 00:02:15 129 modprobe: modprobe: Can't locate module binfmt-0000
> Sep 19 00:02:15 129 kernel: [drm:r128_do_wait_for_fifo] *ERROR*
> r128_do_wait_for_fifo failed!

Thats an X11 3D error, but the bits before it suggest other problems are
triggering it
