Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286979AbRL1SyH>; Fri, 28 Dec 2001 13:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286982AbRL1Sx5>; Fri, 28 Dec 2001 13:53:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5387 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286979AbRL1Sxh>; Fri, 28 Dec 2001 13:53:37 -0500
Subject: Re: zImage not supported for 2.2.20?
To: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 28 Dec 2001 19:04:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a0ie3s$s71$1@cesium.transmeta.com> from "H. Peter Anvin" at Dec 28, 2001 10:36:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K2IU-0001TC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> zImage format will probably be removed in the 2.5 series.  It's
> virtually impossible to fit a practical 2.4 kernel within the zImage
> size limits.

2.5 should make it much easier because by the time Al has finished most of
your kernel will be in the initrd not the zImage 8)
