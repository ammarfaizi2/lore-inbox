Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290302AbSBORfB>; Fri, 15 Feb 2002 12:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290306AbSBORen>; Fri, 15 Feb 2002 12:34:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34830 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290302AbSBORed>; Fri, 15 Feb 2002 12:34:33 -0500
Subject: Re: oops with 2.4.18-pre9-mjc2
To: rj@open-net.org (Robert Jameson)
Date: Fri, 15 Feb 2002 17:48:23 +0000 (GMT)
Cc: rml@tech9.net (Robert Love), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <20020215102037.00cf2ad9.rj@open-net.org> from "Robert Jameson" at Feb 15, 2002 10:20:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bmT9-0003m3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's appears right after my PDA finishes syncing, so im guessing, its
> during a device close. To answer alans question im using nVidias kernel
> driver, therefor i tainted the kernel (tm) (c).

Please take your bug report to Nvidia. You'll find the binary module
needs recompiling for pre-empt. Have fun with them 8)
