Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273137AbRIPXGx>; Sun, 16 Sep 2001 19:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273147AbRIPXGo>; Sun, 16 Sep 2001 19:06:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27401 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273137AbRIPXGb>; Sun, 16 Sep 2001 19:06:31 -0400
Subject: Re: [patch] block highmem zero bounce v14
To: axboe@suse.de (Jens Axboe)
Date: Mon, 17 Sep 2001 00:10:53 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel), arjanv@redhat.com,
        davem@redhat.com (David S. Miller)
In-Reply-To: <20010917000012.B12270@suse.de> from "Jens Axboe" at Sep 17, 2001 12:00:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15il3t-00061s-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Most of it is really a cautious back port of the 2.5 stuff I've been
> working on, and with the above considerations it is/was meant as a 2.4
> thing :-)

So better deferred until 2.5, tried in 2.5 and backported to 2.4 IMHO

Alan
