Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265426AbRF0WCk>; Wed, 27 Jun 2001 18:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265427AbRF0WCa>; Wed, 27 Jun 2001 18:02:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54279 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265426AbRF0WCQ>; Wed, 27 Jun 2001 18:02:16 -0400
Subject: Re: Allocating non-contigious memory
To: rhw@MemAlpha.CX (Riley Williams)
Date: Wed, 27 Jun 2001 23:01:26 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0106272229250.26936-100000@infradead.org> from "Riley Williams" at Jun 27, 2001 10:31:22 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FNNG-0005vf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it be useful to turn that particular code into a subroutine that
> is called from each driver, or would that cause other problems?

It would but then I suspect Linus wouldnt want to take it as it might
encourage people to use it 8)

