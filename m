Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287505AbRLaNCg>; Mon, 31 Dec 2001 08:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287506AbRLaNC0>; Mon, 31 Dec 2001 08:02:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32270 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287505AbRLaNCM>; Mon, 31 Dec 2001 08:02:12 -0500
Subject: Re: merge in progress.
To: davej@suse.de (Dave Jones)
Date: Mon, 31 Dec 2001 13:12:39 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <20011231031506.A1537@suse.de> from "Dave Jones" at Dec 31, 2001 03:15:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16L2F5-00050A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Things unlikely to merge yet.
> o  Alans aacraid driver (not bio aware)

Thats fine. I don't plan to worry about that until 2.5 is a lot more stable.
Its more important to get the 64bit stuff tidied. I'll push that forward in
time along with the NCR5380 series changes in 2.4 that are needed before you
can even begin to fix the 5380 driver for 2.5

Alan
