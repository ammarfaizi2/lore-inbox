Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWJQQyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWJQQyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWJQQyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:54:41 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:62394 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751325AbWJQQyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:54:39 -0400
Date: Tue, 17 Oct 2006 18:53:48 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Miller <davem@davemloft.net>
cc: andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Sparc64 kernel message: BUG: soft lockup detected on CPU#3!
In-Reply-To: <20061016.174100.48529083.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0610170843150.17410@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610162358270.30479@yvahk01.tjqt.qr>
 <20061016.153720.115911255.davem@davemloft.net> <Pine.LNX.4.61.0610170053280.30479@yvahk01.tjqt.qr>
 <20061016.174100.48529083.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>What kind of system is this?

Yes it's Ultra/E250.

>The two SU serial ports are usually for keyboard and mouse.
>
>If you have 4 SAB ports, I'm guessing this is an Ultra250.
>The 3rd and 4th SAB port are usually used for RSC on the
>Ultra250 machines, the 1st and 2nd for normal ttya and ttyb
>serial.

ttya... backside. ttyb... backside. RSC... backside in a PCI slot, that 
makes three. Where is the 4th?


	-`J'
-- 
