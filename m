Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbRBLPpm>; Mon, 12 Feb 2001 10:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130808AbRBLPpc>; Mon, 12 Feb 2001 10:45:32 -0500
Received: from [209.81.55.2] ([209.81.55.2]:51461 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S129811AbRBLPpW>;
	Mon, 12 Feb 2001 10:45:22 -0500
Date: Mon, 12 Feb 2001 07:45:17 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: LILO and serial speeds over 9600
Message-ID: <Pine.LNX.4.10.10102120741290.3761-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'd like to have a LILO version that supports higher serial speeds than
9600bps. Questions:
- Is there a version that already does that?
- If not, do I need to change just LILO to do that, or do I need to change
  the kernel as well (I don't think I'd need to do that too, as the serial 
  console kernel code does support up to 115.2Kbps, but it doesn't hurt to 
  ask ... ;) ??
- Does another bootloader (e.g. GRUB) support serial speeds higher than
  9600bps?? If so, which one(s)??

TIA for your help!!

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
