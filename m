Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271147AbRHTJ4k>; Mon, 20 Aug 2001 05:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271151AbRHTJ4a>; Mon, 20 Aug 2001 05:56:30 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11526 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271147AbRHTJ4M>; Mon, 20 Aug 2001 05:56:12 -0400
Subject: Re: VIA fix breaks BTTV overlay
To: m.guntsche@epitel.at (Michael Guntsche)
Date: Mon, 20 Aug 2001 10:59:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <NDBBJOKGIPCDBEEFHNFPEEMGCAAA.m.guntsche@epitel.at> from "Michael Guntsche" at Aug 20, 2001 07:23:55 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Ylpw-0005hz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I noticed following problem with recent kernels 2.4.[3-8]. If I use overlay
> with my Brooktree card and the window has a certain size, the picture is
> broken. After digging through the mailinglist archive I found a fix.

use the -ac kernel tree. That problem has been fixed in -ac for ages. So far
Linus hasn't taken the patch to sort it

