Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272174AbRHWK0Z>; Thu, 23 Aug 2001 06:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272192AbRHWK0P>; Thu, 23 Aug 2001 06:26:15 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:52366 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S272174AbRHWK0D>;
	Thu, 23 Aug 2001 06:26:03 -0400
Date: Thu, 23 Aug 2001 12:26:02 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Busch <jbusch@half.com>, linux-kernel@vger.kernel.org
Subject: Re: [problem] RH 2.4.7-2 kernel slows to a crawl under heavy i/o
Message-ID: <20010823122602.A14147@se1.cogenit.fr>
In-Reply-To: <NEBBJGKHGENBAPAMDILGIEFGGOAA.jbusch@half.com> <E15ZgEU-0002QS-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15ZgEU-0002QS-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Aug 22, 2001 at 11:12:18PM +0100
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> :
> > The same setup on RH 6.2 with 2.4.3-ac3 works fine.  Please let me know what
> > information may be useful to debugging this problem (no oops yet), and other
> > kernels to try; I'm looking at 2.4.8-ac9 right now.
> 
> I'd be interested to know how 2.4.8-ac9 fares. It has the saner parts of
> the VM work from the Linus tree and other stuff from Rik, Marcelo and co.

I have added the data of 2.4.8-ac7 build for 2.4.8-ac{8,9} at
http://www.cogenit.fr/linux/bench/. The graphs are under 2.4.8-acXX/img.
The successive runs on a same session are now bounded on the graphs.
The occasionaly high levels of irq and cs on ac9 says nothing good about
interactivity.

-- 
Ueimor
