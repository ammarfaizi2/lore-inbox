Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270258AbRHMPoJ>; Mon, 13 Aug 2001 11:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270257AbRHMPn6>; Mon, 13 Aug 2001 11:43:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19462 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270255AbRHMPnt>; Mon, 13 Aug 2001 11:43:49 -0400
Subject: Re: S2464 (K7 Thunder) hangs -- some lessons learned
To: esr@thyrsus.com
Date: Mon, 13 Aug 2001 16:46:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20010813111850.D21008@thyrsus.com> from "Eric S. Raymond" at Aug 13, 2001 11:18:50 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WJv2-0007eS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know what version we have.  Is there a way to query it through /proc?

You need to look at the lspci hex data. There's an errata document for the
MP chipset on www.amd.com if you realyl want to scare yourself 8)

Alan
--
  "Have you noticed the way people's intelligence capabilities decline
   sharply the minute they start waving guns around?"
 		-- Dr. Who
