Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288477AbSANApa>; Sun, 13 Jan 2002 19:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288494AbSANAoC>; Sun, 13 Jan 2002 19:44:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13837 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288477AbSANAnB>; Sun, 13 Jan 2002 19:43:01 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: Robert.Lowery@colorbus.com.au (Robert Lowery)
Date: Mon, 14 Jan 2002 00:51:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
In-Reply-To: <370747DEFD89D2119AFD00C0F017E66156A8AE@cbus613-server4.colorbus.com.au> from "Robert Lowery" at Jan 14, 2002 11:33:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PvLX-00005W-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Quick question from a kernel newbie.
> 
> Could this audit be partially automated by the Stanford Checker? or would
> there be too many false positives from other similar looping code?

Some it can probably be audited but much of this stuff depends on knowing
the hardware. I've yet to meet a gcc that can read manuals alas

