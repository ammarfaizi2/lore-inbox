Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285070AbRLVKKy>; Sat, 22 Dec 2001 05:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286752AbRLVKKo>; Sat, 22 Dec 2001 05:10:44 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:60056 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S285070AbRLVKKe>; Sat, 22 Dec 2001 05:10:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Keys <akeys@post.cis.smu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE Harddrive Performance
Date: Sat, 22 Dec 2001 04:10:38 -0600
X-Mailer: KMail [version 1.3.2]
Cc: thomas@deselaers.de (Thomas Deselaers), linux-kernel@vger.kernel.org
In-Reply-To: <E16Hhws-0003Rj-00@the-village.bc.nu>
In-Reply-To: <E16Hhws-0003Rj-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011222101028.DCPB6450.rwcrmhc52.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 22, 2001 02:56, Alan Cox wrote:
> > # hdparm -t /dev/hda
> >
> > /dev/hda:
> >  Timing buffered disk reads:  64 MB in 86.98 seconds =753.46 kB/sec
>
> Do you get sane numbers if you use 2.4.9 for the hdparm test ?

Just tried 2.4.9 and 2.4.10, both with ext3 patches.  Both had the same 
abysmal numbers (791.48 KB/sec for 2.4.9).

Any other combinations I should try?
-- 
akk~

