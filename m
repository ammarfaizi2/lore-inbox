Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbTAPF3z>; Thu, 16 Jan 2003 00:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267033AbTAPF3z>; Thu, 16 Jan 2003 00:29:55 -0500
Received: from [148.246.67.111] ([148.246.67.111]:6404 "EHLO zion.mx")
	by vger.kernel.org with ESMTP id <S267030AbTAPF3y>;
	Thu, 16 Jan 2003 00:29:54 -0500
Date: Wed, 15 Jan 2003 23:39:33 -0600
From: Felipe Contreras <al593181@mail.mty.itesm.mx>
To: linux-kernel@vger.kernel.org
Subject: Tulip problem with linux > 2.5.56
Message-ID: <20030116053932.GA177@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I keep getting these errors after a random while, somethinmes I don't.

NETDEV WATCHDOG: eth0: transmit timed out

I use the tulip driver and my card is a Conexant LANfinity. I use
fullduplex and it always worked fine. But since the latest kernels,
possibly since 2.5.54 I get those errors and the card is not usable
anymore.

I'm not sure since when started the errors. I'm sure in 2.5.56 and 2.5.58
it happened.

I'll try to check if something happends with halfduplex.

-- 
Felipe Contreras
