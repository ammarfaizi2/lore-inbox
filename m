Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271981AbRH2Of6>; Wed, 29 Aug 2001 10:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271982AbRH2Ofs>; Wed, 29 Aug 2001 10:35:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61190 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271981AbRH2Ofj>; Wed, 29 Aug 2001 10:35:39 -0400
Subject: Re: IDE drive won't come back after power down
To: andre@aslab.com (Andre Hedrick)
Date: Wed, 29 Aug 2001 15:38:08 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        RossBoylan@stanfordalumni.org (Ross Boylan), sfr@canb.auug.org.au,
        andre@suse.com (Andre Hedrick), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0108261844570.12817-100000@postbox.aslab.com> from "Andre Hedrick" at Aug 28, 2001 09:29:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15c6To-0007iA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That is the prefered location; however, setting/writing up hold over code
> that will be deleted in 2.5 is silly.  The basics are the non-data
> taskfile registers operations.

Well if you can do it already in userspace via ioctl clearly the needed
kernel code is small
