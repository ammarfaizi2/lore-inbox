Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263742AbRFEI1p>; Tue, 5 Jun 2001 04:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263803AbRFEI1f>; Tue, 5 Jun 2001 04:27:35 -0400
Received: from [194.128.63.73] ([194.128.63.73]:1968 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S263742AbRFEI1X>; Tue, 5 Jun 2001 04:27:23 -0400
Message-ID: <3B1C986B.BA6522CC@ukaea.org.uk>
Date: Tue, 05 Jun 2001 09:29:31 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
Organization: UKAEA Fusion
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: IDE corruption, 2.2, VIA chipset in PIO mode
In-Reply-To: <E156y8B-0005eg-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > Sigh.  Ah, I think I see a nice brown bag, in a nice deep hole.
> 
> Its only a pointer. PIO speed cable errors tend to  imply a bad cable problem
> (eg not properly connected ribbon). So it could still be that the problem is
> elsewhere

Ah OK.  Though a cable fault does seem consistent with the evidence...
(I swear I read the FAQ before posting!)

In practice, does a BadCRC error EVER imply a crap/buggy chipset?

On the flip side, the cable isn't too long, isn't damaged, and was very
definitely seated properly (I did it personally and took some care over
that).  On the third hand, I don't know where it came from, and somebody
had spilled coffee on it in a previous life :-) (not the connectors!).

To approach the question from a different angle completely: DARE I use
the VIA 686A in UDMA-33/66[/100 if capable?] mode, or is it not really
up to the job?  I've seen so many posts on a search for "linux via ide
corruption" that I'm uneasy about repeating the experiments on what is a
production box...

thanks,
Neil
PS: 80pin cables on the way :-)
