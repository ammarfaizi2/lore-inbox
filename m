Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUC3QvN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 11:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263747AbUC3QvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 11:51:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19910 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263743AbUC3QvJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 11:51:09 -0500
Message-ID: <4069A56B.9060609@pobox.com>
Date: Tue, 30 Mar 2004 11:50:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Lionel Bergeret <lbergeret@swing.be>, JunHyeok Heo <jhheo@idis.co.kr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Bogus LBA48 drives
References: <Pine.LNX.4.10.10403300821520.11654-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10403300821520.11654-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> Actually this issue an errata correction in ATA-6 and changed in ATA-7.
> 
> 48-bit command set support is different than capacity.
> 
> A fix that address the erratium is prefered, just need to take some time
> to read it.

Got a URL?

I only see an ATA-6 errata that talks about Packet DMA...

	Jeff




