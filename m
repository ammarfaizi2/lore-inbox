Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267864AbUHEXN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbUHEXN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267790AbUHEXN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:13:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19375 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267752AbUHEXN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:13:56 -0400
Message-ID: <4112BF1E.9070404@pobox.com>
Date: Thu, 05 Aug 2004 19:13:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Brett Russ <russb@emc.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] (IDE) restore access to low order LBA following error
References: <41126458.1050203@emc.com> <1091724300.8043.58.camel@localhost.localdomain>
In-Reply-To: <1091724300.8043.58.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Once Jeff has MWDMA and ATAPI in the new SATA/ATA driver he wrote then
> migration might be an even better option. It'll certainly be easier to
> do a lot of things right with the newest SATA code than with the current
> IDE layer.


BTW MWDMA is already done and checked in :)

