Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAOSES>; Mon, 15 Jan 2001 13:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbRAOSEI>; Mon, 15 Jan 2001 13:04:08 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:38149 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129401AbRAOSEA>;
	Mon, 15 Jan 2001 13:04:00 -0500
Date: Mon, 15 Jan 2001 18:04:00 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: dep <dennispowell@earthlink.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide that *does* work well with 2.4.0?
In-Reply-To: <01011512480000.02541@depoffice.localdomain>
Message-ID: <Pine.LNX.4.30.0101151759160.8483-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, dep wrote:
> i've got to get another udma ide drive today or tomorrow. i know that
> my w.d. is a little flaky, and i've seen reports that at least some
> ibm drives are kind of screwy with 2.4.0.

I have used IBM drives with Intel PIIX, Promise ATA100 and various VIA
chipsets on 2.4.  They have been extremely fast and reliable.  There were
some reports with troubles with IBM disks and a specific chipset, but it
may just as well be the chipset.  Hard to prove without an ATA analyzer
and a full spec...

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
