Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271803AbRHUSjW>; Tue, 21 Aug 2001 14:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271811AbRHUSiy>; Tue, 21 Aug 2001 14:38:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18693 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271803AbRHUShm>; Tue, 21 Aug 2001 14:37:42 -0400
Subject: Re: [Patch] sysinfo compatibility
To: cr@sap.com (Christoph Rohland)
Date: Tue, 21 Aug 2001 19:40:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hugh@veritas.com (Hugh Dickins),
        andersee@debian.org (Erik Andersen),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <m3y9od1ftm.fsf@linux.local> from "Christoph Rohland" at Aug 21, 2001 07:30:13 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZGRX-0008Qn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There are callers who did add ram + swap
> And that's a reason to break compatibility?
 
We had to break compatibility anyway for 2.4

