Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316891AbSE3Vhv>; Thu, 30 May 2002 17:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316892AbSE3Vhu>; Thu, 30 May 2002 17:37:50 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:23032 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316891AbSE3Vhu>; Thu, 30 May 2002 17:37:50 -0400
Subject: Re: 3c59x.c Linux driver patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Angelo Archie Amoruso <aamoruso@libero.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020530230306.7a2caa09.aamoruso@libero.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 May 2002 23:41:46 +0100
Message-Id: <1022798506.4124.389.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-30 at 22:03, Angelo Archie Amoruso wrote: 
> I'm sending you a diff file for a patch to the Linux
> 3c59x.c driver (from the 2.4.18 vanilla source tree), 
> in order to support some strange 3C905-B
> cards which map themselves on PCI device 00B7:9055.

That sounds like the eeprom is faulty on your card or the card isn't in
the slot properly. 

Alan

