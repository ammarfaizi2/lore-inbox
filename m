Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132301AbRDCRCK>; Tue, 3 Apr 2001 13:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132313AbRDCRB5>; Tue, 3 Apr 2001 13:01:57 -0400
Received: from [212.17.18.2] ([212.17.18.2]:43281 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id <S132301AbRDCRBm>;
	Tue, 3 Apr 2001 13:01:42 -0400
Message-Id: <200104031700.AAA02001@gw.ac-sw.com>
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
To: linux-kernel@vger.kernel.org
Subject: Re: EATA driver with DPT SmartRAID V
Date: Tue, 3 Apr 2001 23:58:49 +0700
X-Mailer: KMail [version 1.2.1]
In-Reply-To: <E14kU96-0008RI-00@the-village.bc.nu>
In-Reply-To: <E14kU96-0008RI-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 April 2001 23:59, Alan Cox wrote:
> >   Bus  1, device   1, function  0:
> >     PCI bridge: Distributed Processing Technology PCI Bridge (rev 2).
> >       Master Capable.  Latency=64.  Min Gnt=3.
> >   Bus  1, device   1, function  1:
> >     I2O: Distributed Processing Technology SmartRAID V Controller (rev
> > 2).
>
> This card isnt supported by the eata driver.

Is there any other way to make it working under 2.4.x? Only working drivers 
are up to 2.2.16. I tried to compile them for 2.2.17 from RH 6.2 updates, but 
they hang up PC.

-- 
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------
