Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281160AbRLIBcQ>; Sat, 8 Dec 2001 20:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281180AbRLIBcI>; Sat, 8 Dec 2001 20:32:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57611 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281160AbRLIBbz>; Sat, 8 Dec 2001 20:31:55 -0500
Subject: Re: Linux HMT analysis
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 9 Dec 2001 01:41:00 +0000 (GMT)
Cc: anton@samba.org (Anton Blanchard), rusty@rustcorp.com.au (Rusty Russell),
        alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <E16Csvv-0003Tp-00@the-village.bc.nu> from "Alan Cox" at Dec 09, 2001 01:39:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Csxg-0003U4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Otherwise there will shortly be yet another hack in the scheduler
> > surrounded by #ifdef CONFIG_PPC64_HMT :)

Oh and a PS. Can you send me the PPC64_HMT scheduler hack to look at. If its
sane for 2.4 I can then see if the intel guys think it works for them too.

Alan
