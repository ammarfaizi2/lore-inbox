Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269356AbRGaQlC>; Tue, 31 Jul 2001 12:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269359AbRGaQkz>; Tue, 31 Jul 2001 12:40:55 -0400
Received: from smarty.smart.net ([207.176.80.102]:10771 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S269356AbRGaQki>;
	Tue, 31 Jul 2001 12:40:38 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200107311658.MAA03706@smarty.smart.net>
Subject: Re: LANCE ethernet chip - ~24 drivers
To: linux-kernel@vger.kernel.org
Date: Tue, 31 Jul 2001 12:58:10 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Jan-Benedict Glaw
>That are *many* drivers for at least *one* chip. For now, I'm
>working to get a serial keyboard running. However - having
>more than 20 drivers for one kind of device sucks a lot. So


One has to wonder. I was looking at 1.2.13 and there is mention of
splitting a driver, I forget which one, because there are two bits with
reversed sense in later versions of a card. 

This raises a question about open source. How do you aknowledge code
removal? Given a system at some level of existing functionality, removing
code is one of the best things you can do for it, but it doesn't get your
name anywhere that sticks. Maybe Linux needs a linux/NO_MAINTENANCE .

Rick Hohensee
					www.clienux.com

