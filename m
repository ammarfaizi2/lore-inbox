Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBHINw>; Thu, 8 Feb 2001 03:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130835AbRBHINm>; Thu, 8 Feb 2001 03:13:42 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15881 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129033AbRBHINa>; Thu, 8 Feb 2001 03:13:30 -0500
Subject: Re: aacraid 2.4.0 kernel
To: axboe@suse.de (Jens Axboe)
Date: Thu, 8 Feb 2001 08:13:58 +0000 (GMT)
Cc: Matt_Domsch@Dell.com, jason@heymax.com, linux-kernel@vger.kernel.org,
        gandalf@winds.org
In-Reply-To: <20010208041814.I27027@suse.de> from "Jens Axboe" at Feb 08, 2001 04:18:14 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QmDJ-0002pJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> total request sizes. I would rather fix this limitation then, and
> would also be interested to know if any of the (older) SCSI drivers
> have such limitations too.

And some new ones. One of my i2o scsi controllers has that problem. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
