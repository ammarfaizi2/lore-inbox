Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270050AbRH1Ac4>; Mon, 27 Aug 2001 20:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270036AbRH1Acp>; Mon, 27 Aug 2001 20:32:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57611 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270011AbRH1Acd>; Mon, 27 Aug 2001 20:32:33 -0400
Subject: Re: VM: Bad swap entry 0044cb00
To: moz@compsoc.man.ac.uk (John Levon)
Date: Tue, 28 Aug 2001 01:32:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010828012308.A36433@compsoc.man.ac.uk> from "John Levon" at Aug 28, 2001 01:23:09 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bWnx-00055w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fwiw, this seems to be a common characteristic of hardware problems with
> 2.4 kernels. I've had bad RAM (discovered by memtest86) which was producing
> this error without any swapoff. Once it only occurred after an entire night
> of kernel compiles (memtest86 found it easily however)

Worth testing maybe, but the -ac tree does have memory changes although not
between 8ac12 and 9ac2.
