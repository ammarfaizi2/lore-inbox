Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276060AbRI1OEf>; Fri, 28 Sep 2001 10:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276061AbRI1OEZ>; Fri, 28 Sep 2001 10:04:25 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30726 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276060AbRI1OEO>; Fri, 28 Sep 2001 10:04:14 -0400
Subject: Re: ide drive problem?
To: lgb@lgb.hu
Date: Fri, 28 Sep 2001 15:05:53 +0100 (BST)
Cc: therapy@endorphin.org (clemens), linux-kernel@vger.kernel.org
In-Reply-To: <20010928150936.B12586@vega.digitel2002.hu> from "=?iso-8859-2?B?R+Fib3IgTOlu4XJ0?=" at Sep 28, 2001 03:09:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15myH3-00076i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> Hmmm, I get this message as well about once a day (though it seems it
> could not cause any damage ... yet ...)

BadCRC is a transmission error on the IDE cable. It will be retried so
it isnt a problem. 
