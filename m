Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273577AbRJPII4>; Tue, 16 Oct 2001 04:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273912AbRJPIIq>; Tue, 16 Oct 2001 04:08:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6666 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273870AbRJPIIb>; Tue, 16 Oct 2001 04:08:31 -0400
Subject: Re: random reboots of diskless nodes - 2.4.7 (fwd)
To: rsweet@atos-group.nl (Ryan Sweet)
Date: Tue, 16 Oct 2001 09:14:59 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0110160228000.18043-100000@core-0> from "Ryan Sweet" at Oct 16, 2001 02:28:46 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15tPNL-00050f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serial console might help. When a box dies/reboots it may log something just
before it dies that you will see on a serial console on a second box. But
thats only a maybe.

Spontaneous reboots and hardware level freezes are about the worst things to
debug.
