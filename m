Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271667AbRHUNwr>; Tue, 21 Aug 2001 09:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271670AbRHUNwg>; Tue, 21 Aug 2001 09:52:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28177 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271667AbRHUNwW>; Tue, 21 Aug 2001 09:52:22 -0400
Subject: Re: [Patch] sysinfo compatibility
To: hugh@veritas.com (Hugh Dickins)
Date: Tue, 21 Aug 2001 14:50:48 +0100 (BST)
Cc: cr@sap.com (Christoph Rohland), alan@lxorguk.ukuu.org.uk (Alan Cox),
        andersee@debian.org (Erik Andersen),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.21.0108211137340.1320-100000@localhost.localdomain> from "Hugh Dickins" at Aug 21, 2001 11:59:53 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZBvd-0007q8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> before) to make that decision; but concluded it was helping callers
> who might well go on to add ram+swap, and felt no overriding reason
> to change that.  But you can certainly argue that's inappropriate

There are callers who did add ram + swap

