Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283714AbRLCXq2>; Mon, 3 Dec 2001 18:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278492AbRLCXa7>; Mon, 3 Dec 2001 18:30:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37639 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282990AbRLCJVb>; Mon, 3 Dec 2001 04:21:31 -0500
Subject: Re: OSS driver cleanups.
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Mon, 3 Dec 2001 09:30:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.33.0112031105230.28692-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Dec 03, 2001 11:11:56 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ApQV-0006HW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know OSS will be replaced with ALSA soon, but i've got a couple of OSS
> cleanup patches lined up (module usage count, power management patches
> for two cards) for both 2.4.x and 2.5.x, should i continue with them or is
> it not worthwhile?

Well if you've done the work why not - people will be running 2.4 for a long
time. The PM changes may also be relevant to ALSA anyway
