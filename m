Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWFTPR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWFTPR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWFTPR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:17:27 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:18631 "EHLO mail.mnsspb.ru")
	by vger.kernel.org with ESMTP id S1751310AbWFTPRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:17:25 -0400
From: Kirill Smelkov <kirr@mns.spb.ru>
Organization: MNS
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: disable dma for transcend CF
Date: Tue, 20 Jun 2006 19:18:16 +0400
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <200606201452.37905.kirr@mns.spb.ru> <1150811003.11062.45.camel@localhost.localdomain>
In-Reply-To: <1150811003.11062.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606201918.18412.kirr@mns.spb.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

[...]
> >     hdc: dma_timer_epiry: dma_status == 0x21
> 
> Almost certainly a problem with the CF adapter. Please verify the card
> in a modern CF adapter and also do tests with DMA capable cards of other
> types on the adapter you are using.
Thanks for the info.

I'll try this if, and when necceessary hardware is available.
At the time being i have to stick to these two.

-- 
	Kirill

