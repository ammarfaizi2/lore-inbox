Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129630AbQKGWSn>; Tue, 7 Nov 2000 17:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129642AbQKGWSe>; Tue, 7 Nov 2000 17:18:34 -0500
Received: from kanga.kvack.org ([216.129.200.3]:19205 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S129630AbQKGWSS>;
	Tue, 7 Nov 2000 17:18:18 -0500
Date: Tue, 7 Nov 2000 17:16:43 -0500 (EST)
From: <kernel@kvack.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
In-Reply-To: <20001107231056.A23564@lug-owl.de>
Message-ID: <Pine.LNX.3.96.1001107171618.1224A-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Jan-Benedict Glaw wrote:

> [...]
> > NMI:  190856196  190856196 
> > LOC:  190858464  190858463 
> 
> ...are these two lines okay? I've noticed that as well, but I've not
> seen that on UP machines as well...

Yes, please don't worry, it's just the NMI watchdog doing its work.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
