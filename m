Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbRF0LV7>; Wed, 27 Jun 2001 07:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264279AbRF0LVt>; Wed, 27 Jun 2001 07:21:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48144 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264173AbRF0LVj>; Wed, 27 Jun 2001 07:21:39 -0400
Subject: Re: PCI Power Management / Interrupt Context
To: eger@cc.gatech.edu (David T Eger)
Date: Wed, 27 Jun 2001 12:20:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, eger@cc.gatech.edu
In-Reply-To: <Pine.SOL.4.21.0106262208240.3824-100000@oscar.cc.gatech.edu> from "David T Eger" at Jun 26, 2001 10:42:37 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FDNR-00051y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> when I read documentation (Documentation/pci.txt) which mentions that
> remove() can be called from interrupt context.

This I believe is in fact a documentation error

