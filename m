Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKUSsY>; Tue, 21 Nov 2000 13:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129682AbQKUSsO>; Tue, 21 Nov 2000 13:48:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43852 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129150AbQKUSr6>; Tue, 21 Nov 2000 13:47:58 -0500
Subject: Re: Linux 2.4.0test11-ac1
To: johannes@erdfelt.com (Johannes Erdfelt)
Date: Tue, 21 Nov 2000 18:18:33 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20001121131445.I7764@sventech.com> from "Johannes Erdfelt" at Nov 21, 2000 01:14:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yI03-0004yv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Nov 21, 2000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > o	Dont crash on boot with a dual cpu board holding a non intel cpu
> 
> Is this the patch to check for the Local APIC?

Yep

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
