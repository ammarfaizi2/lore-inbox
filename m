Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132265AbRBDU00>; Sun, 4 Feb 2001 15:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132283AbRBDU0Q>; Sun, 4 Feb 2001 15:26:16 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3344 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132265AbRBDU0L>; Sun, 4 Feb 2001 15:26:11 -0500
Subject: Re: PS hanging in 2.4.1 - More interesting things
To: Shawn.Starr@Home.net (Shawn Starr)
Date: Sun, 4 Feb 2001 20:27:06 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3A7DB9C7.7D9C3751@Home.net> from "Shawn Starr" at Feb 04, 2001 03:21:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PVka-00026u-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, strangely, it stopped as it started?
> I don't know what caused it to go loopy but then it just stopped. Im using:
> syslogd -ver
> syslogd 1.4-0
> 
> klogd -v
> klogd 1.4-0
> 
> I thought this only affected older versions?

Yep. So something else happened in this case. I don't know what but that
would appear to be a different bug

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
