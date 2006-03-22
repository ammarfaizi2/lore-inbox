Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWCVL1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWCVL1l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 06:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWCVL1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 06:27:41 -0500
Received: from smtp5.libero.it ([193.70.192.55]:27830 "EHLO smtp5.libero.it")
	by vger.kernel.org with ESMTP id S1750710AbWCVL1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 06:27:40 -0500
From: <mtassinari@libero.it>
To: "'Samuel Masham'" <samuel.masham@gmail.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       <mtassinari@cmanet.it>
Subject: R: libata/sata errors on ich[?]/maxtor
Date: Wed, 22 Mar 2006 12:27:31 +0100
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAcm3p+dGrIEuKvCi2uAOJU8KAAAAQAAAA9t1sKjAsk0SX1D4Cs3T+sAEAAAAA@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
In-Reply-To: <93564eb70603220159wd03a48du@mail.gmail.com>
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel, All,

> > >
> > > Eventually the drive will be offlined.
> >
> > really? I can test that easily enough if nothing else :)
>
> When is it (should it) going to offline the drive? its been spitting out
these messages (about set per min?) for 4 hours at the moment with > no
change bar the sector number increasing by 2 each time...
>


confirm. tryed with cables about 4 inches long,
to no success. The process doing the i/o hangs and cannot be killed, so no 
proper sync or shutdown other than reset is possible.
2.6.16 release shows no improvement.
2.6.16-rc6-mm2 does not even recognise the maxtor at boot...
btw, a couple of WD drives went flawless.



Mauro

