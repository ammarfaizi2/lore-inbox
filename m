Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290823AbSCDBSx>; Sun, 3 Mar 2002 20:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289621AbSCDBSn>; Sun, 3 Mar 2002 20:18:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6161 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290796AbSCDBSk>; Sun, 3 Mar 2002 20:18:40 -0500
Subject: Re: latency & real-time-ness.
To: joe@tmsusa.com (J Sloan)
Date: Mon, 4 Mar 2002 01:33:01 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), greearb@candelatech.com (Ben Greear),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3C82C95D.5010703@tmsusa.com> from "J Sloan" at Mar 03, 2002 05:09:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hhLZ-00067I-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It might be very difficult to fix up the
> low latency patch for the latest -ac,

You should be able to just dump out the vm part of it - Rik put that into
rmap anyuway afaik

