Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbRDJLeP>; Tue, 10 Apr 2001 07:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbRDJLeG>; Tue, 10 Apr 2001 07:34:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55556 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131481AbRDJLeA>; Tue, 10 Apr 2001 07:34:00 -0400
Subject: Re: Version 6.1.11 of the aic7xxx driver availalbe
To: wakko@animx.eu.org (Wakko Warner)
Date: Tue, 10 Apr 2001 12:34:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), gibbs@scsiguy.com (Justin T. Gibbs),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010410071334.A706@animx.eu.org> from "Wakko Warner" at Apr 10, 2001 07:13:34 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14mwQD-00044Q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2.4 but then so does IDE DMA for example. The real test would be to run
> > Justin's 2.2.19 patch driver and see if that works on Alpha.
> 
> Sure, I'll try it.  I didn't have any luck with the one from 2.2.17 or
> 2.2.18 on this system.

If the original aic7xxx driver works on your Alpha and Justin's does not 
both under 2.2 then I consider it very unlikely the bug is anywhere but Justin's
driver
