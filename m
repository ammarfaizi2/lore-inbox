Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262116AbRENPCP>; Mon, 14 May 2001 11:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262117AbRENPCF>; Mon, 14 May 2001 11:02:05 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18949 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262116AbRENPCA>; Mon, 14 May 2001 11:02:00 -0400
Subject: Re: [NEW SCSI DRIVER] for 53c700 chip and NCR_D700 card against 2.4.4
To: rhirst@linuxcare.com (Richard Hirst)
Date: Mon, 14 May 2001 15:58:01 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), Andries.Brouwer@cwi.nl,
        James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20010514134129.C24646@linuxcare.com> from "Richard Hirst" at May 14, 2001 01:41:29 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zJnO-0000pG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, May 13, 2001 at 11:40:33PM +0100, Alan Cox wrote:
> > > If I am not mistaken, Richard Hirst has also done work on this thing.
> > 
> > He did 53c710+. The 700 and 700/66 are much less capable devices.
> 
> I did 53c700 as well, in the parisc-linux tree.  Sounds like James'
> driver is more featureful than mine though.

I'll skip feeding the driver on to Linus until the two of you figure out the
best path then

