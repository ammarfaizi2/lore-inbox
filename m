Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279528AbRJ3I4t>; Tue, 30 Oct 2001 03:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279821AbRJ3I4h>; Tue, 30 Oct 2001 03:56:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1041 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279528AbRJ3I40>; Tue, 30 Oct 2001 03:56:26 -0500
Subject: Re: please revert bogus patch to vmscan.c
To: davem@redhat.com (David S. Miller)
Date: Tue, 30 Oct 2001 09:03:33 +0000 (GMT)
Cc: bcrl@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011029.155056.23033599.davem@redhat.com> from "David S. Miller" at Oct 29, 2001 03:50:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yUo1-0005ox-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Numbers talk, bullshit walks.

So you are walking somewhere today ?

Dave I can produce equivalently valid microbenchmarks showing Linux works
much better with the scheduler disabled. They are worth about as much as
your benchmarks for that optimisation and they likewise ignore a slightly
important object known as "the big picture"

