Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129404AbQKSTvF>; Sun, 19 Nov 2000 14:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129501AbQKSTu4>; Sun, 19 Nov 2000 14:50:56 -0500
Received: from jabberwock.ucw.cz ([62.168.0.131]:26890 "EHLO jabberwock.ucw.cz")
	by vger.kernel.org with ESMTP id <S129404AbQKSTuk>;
	Sun, 19 Nov 2000 14:50:40 -0500
Date: Sun, 19 Nov 2000 20:20:33 +0100
From: Martin Mares <mj@suse.cz>
To: Steven Walter <srwalter@hapablap.dyn.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "No IRQ known for interrupt pin A..." error message
Message-ID: <20001119202033.A272@albireo.ucw.cz>
In-Reply-To: <20001118181110.A424@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001118181110.A424@hapablap.dyn.dhs.org>; from srwalter@hapablap.dyn.dhs.org on Sat, Nov 18, 2000 at 06:11:10PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> During boot, I get the message:
> 
> PCI: No IRQ known for interrupt pin A of device 00:00.1. Please try
> using pci=biosirq.

Can you send me 'lspci -vvx' output, please?
 
				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
"System going down at 1:45 for disk crashing."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
