Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQL2Gsa>; Fri, 29 Dec 2000 01:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129667AbQL2GsU>; Fri, 29 Dec 2000 01:48:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62851 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130108AbQL2GsH>;
	Fri, 29 Dec 2000 01:48:07 -0500
Date: Thu, 28 Dec 2000 21:59:55 -0800
Message-Id: <200012290559.VAA03384@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: vonbrand@inf.utfsm.cl
CC: Alan.Cox@linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <200012261709.eBQH99D02130@pincoya.inf.utfsm.cl> (message from
	Horst von Brand on Tue, 26 Dec 2000 14:09:09 -0300)
Subject: Re: 2.2.19pre3 on sparc64: Hangs on boot, "no cont in shutdown!"??
In-Reply-To: <200012261709.eBQH99D02130@pincoya.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"make check_asm" should fix it.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
