Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130864AbRAISmb>; Tue, 9 Jan 2001 13:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRAISmO>; Tue, 9 Jan 2001 13:42:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45581 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131105AbRAISl6>; Tue, 9 Jan 2001 13:41:58 -0500
Subject: Re: Failure building 2.4 while running 2.4.  There is no such thing.
To: silviu@delrom.ro (Silviu Marin-Caea)
Date: Tue, 9 Jan 2001 18:43:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
In-Reply-To: <20010109202036.06741d46.silviu@delrom.ro> from "Silviu Marin-Caea" at Jan 09, 2001 08:20:36 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14G3kQ-0007Ad-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One is bad hardware.  The other is bad user.  I compiled with DMA support
> for SiS 5513 and I have SiS 5571.  My appologies for the stupid mistake.

If the 5513 driver doesnt work on the 5571 it should have ignored it - so
thats a driver bug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
