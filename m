Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271510AbRHPHSJ>; Thu, 16 Aug 2001 03:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271513AbRHPHR7>; Thu, 16 Aug 2001 03:17:59 -0400
Received: from [213.52.152.2] ([213.52.152.2]:63244 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S271510AbRHPHRu>; Thu, 16 Aug 2001 03:17:50 -0400
To: Eugene Crosser <crosser@average.org>
Subject: Re: 2.4.8 USB oddity
Message-ID: <997946242.3b7b7382bed41@extranet.jtrix.com>
Date: Thu, 16 Aug 2001 08:17:22 +0100 (BST)
From: "Martin A. Brooks" <martin@jtrix.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <997884422.3b7a820675961@extranet.jtrix.com> <m15X6Fs-0000W0C@pccross.average.org>
In-Reply-To: <m15X6Fs-0000W0C@pccross.average.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.5
X-Originating-IP: 10.119.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Quoting Eugene Crosser <crosser@average.org>:
> I noticed this too, on OHCI based notebook, with D-Link USB FM tuner.
> But it's first time I used USB so I don't know if it worked any
> different
> with 2.4.7 and earlier.  I am also getting this message:

Ditto.

>  hub.c: nonzero status in irq: -110
> every minute or so.

Yes, I get a similar error message, particulary when hot plugging devices into
the chain.  


Martin A. Brooks,  Systems Administrator
------------------------------------------------
Jtrix Ltd		t: +44 207 395 4990
57-59 Neal Street	f: +44 207 395 4991
Covent Garden		e: martin@jtrix.org
London WC2H 9PJ		w: http://www.jtrix.org
