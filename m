Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275826AbRI1ECm>; Fri, 28 Sep 2001 00:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275827AbRI1ECd>; Fri, 28 Sep 2001 00:02:33 -0400
Received: from cc839443-a.chmbl1.ga.home.com ([24.5.105.138]:28933 "EHLO spock")
	by vger.kernel.org with ESMTP id <S275826AbRI1ECV>;
	Fri, 28 Sep 2001 00:02:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Joerger <steven@spock.2y.net>
To: linux-kernel@vger.kernel.org
Subject: ide drive problem?
Date: Fri, 28 Sep 2001 00:02:20 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010928041519.968EA4FA00@spock>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

List,

When I enable support for my chipset in the kernel (via kt133) I always get 
these messages:

hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }

over and over and ....

Any clues to whats going on?

Thanks,
Steven Joerger
