Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267539AbRGMVJ3>; Fri, 13 Jul 2001 17:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267540AbRGMVJP>; Fri, 13 Jul 2001 17:09:15 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33799 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267544AbRGMVJE>; Fri, 13 Jul 2001 17:09:04 -0400
Subject: Re: swsusp again [was Re: Switching Kernels without Rebooting?]
To: pavel@suse.cz (Pavel Machek)
Date: Fri, 13 Jul 2001 22:08:51 +0100 (BST)
Cc: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.kernel.org
In-Reply-To: <20010713012417.C122@bug.ucw.cz> from "Pavel Machek" at Jul 13, 2001 01:24:17 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LAB9-0000Fg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Suspend-to-disk, change hardware, restore-from-disk, load neccessary
> modules seems quite easy to do with swsusp. It is very different from
> suspend-to-disk, change kernel, restore-from-disk (which is guaranteed
> to kill you if kernel changes size).

It works for most hw changes. I've used swsusp to replace a burned out 3c509
without rebooting 8)
