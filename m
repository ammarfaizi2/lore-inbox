Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281926AbRKZQuk>; Mon, 26 Nov 2001 11:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281921AbRKZQua>; Mon, 26 Nov 2001 11:50:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4115 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281917AbRKZQuT>; Mon, 26 Nov 2001 11:50:19 -0500
Subject: Re: [PATCH] net/802/Makefile
To: kaos@ocs.com.au (Keith Owens)
Date: Mon, 26 Nov 2001 16:56:17 +0000 (GMT)
Cc: hch@ns.caldera.de (Christoph Hellwig),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <2695.1006782891@ocs3.intra.ocs.com.au> from "Keith Owens" at Nov 27, 2001 12:54:51 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E168P3J-0005g3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was going to do that but AC said that all of net/802 was being
> rewritten and removing cl2llc.c now would just be noise.  The file will
> be removed in kbuild 2.5.

The 802.2LLC layer will be replaced when netbeui goes in
