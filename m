Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129311AbRBSRQ3>; Mon, 19 Feb 2001 12:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129926AbRBSRQU>; Mon, 19 Feb 2001 12:16:20 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59921 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129582AbRBSRQP>; Mon, 19 Feb 2001 12:16:15 -0500
Subject: Re: ymfpci is 2.4.1-ac18
To: proski@gnu.org (Pavel Roskin)
Date: Mon, 19 Feb 2001 17:14:41 +0000 (GMT)
Cc: zaitcev@metabyte.com (Pete Zaitcev), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0102191132020.797-100000@fonzie.nine.com> from "Pavel Roskin" at Feb 19, 2001 12:08:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Uttb-0003wz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I load opl3, /dev/sound/sequencer becomes useful - cat doesn't exit and
> dmesg shows:
> 
> /dev/music: Obsolete (4 byte) API was used by cat

You need opl3. The ymfpci driver is the dsp and enabler for the opl3 gunge


