Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281772AbRKQP6h>; Sat, 17 Nov 2001 10:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281770AbRKQP61>; Sat, 17 Nov 2001 10:58:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49166 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281769AbRKQP6M>; Sat, 17 Nov 2001 10:58:12 -0500
Subject: Re: 2.4.13-ac8: crash on IBM Thinkpad 600x
To: ruf@tik.ee.ethz.ch
Date: Sat, 17 Nov 2001 16:04:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel ml)
In-Reply-To: <20011117165248.A10543@tik.ee.ethz.ch> from "Lukas Ruf" at Nov 17, 2001 04:52:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1657xc-0007cT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.13-ac8 unfortunately crashes on my IBM Thinkpad 600x every now and
> then by a kernel panic.  Unfortunately, not syncing.
> Does anyone has similar experienes and managed a workaround?

Known bug - use ac7 or 2.4.15pre6
