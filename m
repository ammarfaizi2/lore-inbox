Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311314AbSCXR2r>; Sun, 24 Mar 2002 12:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311462AbSCXR2i>; Sun, 24 Mar 2002 12:28:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47631 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311314AbSCXR23>; Sun, 24 Mar 2002 12:28:29 -0500
Subject: Re: [patch 2.5] seq_file for /proc/partitions (take 2)
To: rddunlap@osdl.org
Date: Sun, 24 Mar 2002 17:04:07 +0000 (GMT)
Cc: viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org,
        davej@suse.de
In-Reply-To: <Pine.LNX.4.33.0203232143380.5047-100000@osdlab.pdx.osdl.net> from "rddunlap@osdl.org" at Mar 23, 2002 09:47:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pBPb-0006ih-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan, I have 2.4.18 patch for this, but 2.4.19-pre3-ac6
> includes more (sard ?) partition stats.

Yes. 

> Are those going to 2.5 also?

I hope so.

> Do you want me to merge partition stats and seq_file?

I'll certainly take a diff if you do, and DaveJ I suspect will want to feed
it on to Linus in time.
