Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129616AbQKINeq>; Thu, 9 Nov 2000 08:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129787AbQKINeg>; Thu, 9 Nov 2000 08:34:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63824 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129616AbQKINec>; Thu, 9 Nov 2000 08:34:32 -0500
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
To: rothwell@holly-springs.nc.us (Michael Rothwell)
Date: Thu, 9 Nov 2000 13:35:21 +0000 (GMT)
Cc: lmb@suse.de (Lars Marowsky-Bree), cr@sap.com (Christoph Rohland),
        richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <3A0A9CB6.6A22CFE0@holly-springs.nc.us> from "Michael Rothwell" at Nov 09, 2000 07:46:46 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13trrP-00019n-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Making this "commonplace" is a nightmare. Go away with that.
> 
> It would be a third major fork (AFAIK), not a first, and not a
> nightmare. Are RTLinux and uclinux nightmares? How much do they impact
> your life?

RTLinux is hardly a fork. UcLinux is a fork, it has its own mailing list, web
site and everything. Post 2.4 I'm still very interested in spending time merging
the 2.4 uc and the main tree. I think it can be done and they are doing it in
a way that leads logically to this.

To a lot of people the ucLinux is 2.0 and our MMU based boards run 2.2.18 and
this and that are different is a real pain


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
