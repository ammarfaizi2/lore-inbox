Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276911AbRJHOzd>; Mon, 8 Oct 2001 10:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276912AbRJHOzX>; Mon, 8 Oct 2001 10:55:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22285 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276911AbRJHOzH>; Mon, 8 Oct 2001 10:55:07 -0400
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: andrea@suse.de (Andrea Arcangeli)
Date: Mon, 8 Oct 2001 16:00:36 +0100 (BST)
Cc: mingo@elte.hu (Ingo Molnar), hadi@cyberus.ca (jamal),
        linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru (Alexey Kuznetsov),
        Robert.Olsson@data.slu.se (Robert Olsson),
        bcrl@redhat.com (Benjamin LaHaise), netdev@oss.sgi.com,
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20011008023118.L726@athlon.random> from "Andrea Arcangeli" at Oct 08, 2001 02:31:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qbtV-0000hd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course we agree that such a "polling router/firewall" behaviour must
> not be the default but it must be enabled on demand by the admin via
> sysctl or whatever else userspace API. And I don't see any problem with
> that.

No I don't agree. "Stop random end users crashing my machine at will" is not
a magic sysctl option - its a default. 


Alan
