Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269206AbRHLNzI>; Sun, 12 Aug 2001 09:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269207AbRHLNy6>; Sun, 12 Aug 2001 09:54:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29453 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269206AbRHLNys>; Sun, 12 Aug 2001 09:54:48 -0400
Subject: Re: Lost interrupt with HPT370
To: bloch@verdurin.com (Adam Huffman)
Date: Sun, 12 Aug 2001 14:57:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010812134958.A1203@bloch.verdurin.priv> from "Adam Huffman" at Aug 12, 2001 01:49:58 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Vvjz-0005k2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get hde/hdg: lost interrupt messages when booting with 2.4.7/8.
> 
> There are two IBM DTLA-307030 drives on the HPT370 interface (m/b is
> Abit KA7-100).
> 
> 2.4.6-ac5 (which I had been using for quite a while) does not have this
> problem.

The fixes you need to run certain HPT cards with certain drives (HPT370
included) are not in the Linus tree. Its waiting Andre to submit the
relevant stuff on to Linus
