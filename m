Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280603AbRKLNLt>; Mon, 12 Nov 2001 08:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281420AbRKLNLa>; Mon, 12 Nov 2001 08:11:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3341 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280697AbRKLNL0>; Mon, 12 Nov 2001 08:11:26 -0500
Subject: Re: [PATCH] lvm in 2.4.15.pre3
To: caulfield@sistina.com (Patrick Caulfield)
Date: Mon, 12 Nov 2001 13:19:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linux-lvm@sistina.com,
        torvalds@transmeta.com
In-Reply-To: <20011112130101.A11020@tykepenguin.com> from "Patrick Caulfield" at Nov 12, 2001 01:01:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163GzN-0005po-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please apply the following patch to LVM in 2.4.13pre3.
> 
> It looks like the LVM patch that came from Alan calls alloc/free_kiovec_sz()
> functions which only exist in his tree.

Just sent Linus the same thing 8)

Alan
