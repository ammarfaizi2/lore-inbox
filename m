Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131730AbRDJMhf>; Tue, 10 Apr 2001 08:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRDJMfM>; Tue, 10 Apr 2001 08:35:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19973 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131666AbRDJMey>; Tue, 10 Apr 2001 08:34:54 -0400
Subject: Re: No 100 HZ timer !
To: ak@suse.de (Andi Kleen)
Date: Tue, 10 Apr 2001 13:36:27 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        mbs@mc.com (Mark Salisbury), jdike@karaya.com (Jeff Dike),
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010410143216.A15880@gruyere.muc.suse.de> from "Andi Kleen" at Apr 10, 2001 02:32:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14mxNm-0004BT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's also all interrupts, not only syscalls, and also context switch if you
> want to be accurate.

We dont need to be that accurate. Our sample rate is currently so low the
data is worthless anyway

