Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286240AbRLJMKv>; Mon, 10 Dec 2001 07:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286245AbRLJMKm>; Mon, 10 Dec 2001 07:10:42 -0500
Received: from workplace.tp1.ruhr-uni-bochum.de ([134.147.240.2]:1284 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S286240AbRLJMK2>; Mon, 10 Dec 2001 07:10:28 -0500
Date: Sun, 9 Dec 2001 20:37:05 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: skidley <skidley@crrstv.net>
cc: Pete Zaitcev <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch for ymfpci in pre5
In-Reply-To: <Pine.LNX.4.33L2.0112071213500.2253-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112081652460.1300-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001, skidley wrote:

> Should this ymfpci work with my ymf740C. I have never been able to get
> ymfpci support to work directly from the kernel. I've always used alsa.

If you're using ALSA's ymfpci.o, yes. The in-kernel ymfpci driver is 
heavily based upon the ALSA driver and should therefore support the same 
hardware (and it explicitly mentions the 740C). What problem do you have?

--Kai



