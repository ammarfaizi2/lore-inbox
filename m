Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbREMSob>; Sun, 13 May 2001 14:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbREMSoV>; Sun, 13 May 2001 14:44:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34055 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262835AbREMSoJ>; Sun, 13 May 2001 14:44:09 -0400
Subject: Re: LVM 1.0 release decision
To: dwmw2@infradead.org (David Woodhouse)
Date: Sun, 13 May 2001 19:39:36 +0100 (BST)
Cc: davem@redhat.com (David S. Miller), andrea@suse.de (Andrea Arcangeli),
        alan@lxorguk.ukuu.org.uk (Alan Cox), Mauelshagen@sistina.com,
        linux-kernel@vger.kernel.org, mge@sistina.com, hch@caldera.de
In-Reply-To: <23605.989775371@redhat.com> from "David Woodhouse" at May 13, 2001 06:36:11 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14z0mG-0006og-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is now a sufficiently common requirement that it shouldn't be repeated 
> by all architectures that require it - it should be somewhere common.
> Like linux/abi/ioctl32/

Or the 32bit libc shipped with the 64bit box. Lets face it, there is no reason
you can't have a 32bit glibc 2.2 built to use 64bit calling conventions..

