Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271587AbRHQMHP>; Fri, 17 Aug 2001 08:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271589AbRHQMHF>; Fri, 17 Aug 2001 08:07:05 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8973 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271587AbRHQMGq>; Fri, 17 Aug 2001 08:06:46 -0400
Subject: Re: 2.4.8-ac6 ad1848 module failed at init
To: glouis@dynamicro.on.ca
Date: Fri, 17 Aug 2001 13:09:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <20010817080330.A613@athame.dynamicro.on.ca> from "Greg Louis" at Aug 17, 2001 08:03:30 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XiRS-0007Ed-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> module ad1848 built but failed at init with "No device found."
> 
> I reverted, by copying ad1848.c from the -ac4 tree, and the resulting
> module loaded successfully, and seems to be functioning correctly.

Is your card plug and play ?
