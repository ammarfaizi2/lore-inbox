Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288612AbSANBub>; Sun, 13 Jan 2002 20:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288604AbSANBuV>; Sun, 13 Jan 2002 20:50:21 -0500
Received: from codepoet.org ([166.70.14.212]:56752 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S288603AbSANBuK>;
	Sun, 13 Jan 2002 20:50:10 -0500
Date: Sun, 13 Jan 2002 18:50:12 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18pre3-ac1-aia21 (IDE patches)
Message-ID: <20020114015012.GA17253@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020113232757.04f34ec0@pop.cus.cam.ac.uk> <E16PwJO-0000F8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16PwJO-0000F8-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jan 14, 2002 at 01:53:22AM +0000, Alan Cox wrote:
> > Alan's -ac series is back! To celebrate this I added in the IDE patches and 
> > an NTFS update which dramatically reduces the number of vmalloc()s and have 
> > posted the resulting (tested) patch (to be applied on top of 
> > 2.4.18pre3-ac1) at below URL.
> 
> Andre's IDE patch is in the ac2 cut. I took it out just to make testing easier
> in case other people found -ac1 wasnt as reliable as I did 8)

Will -ac2 be hitting the mirrors shortly then?  BTW, you
mentioned in your earlier email you excluded the low-latency
patches.   Mind if I ask which of the many you are using?
mini-ll?  full-ll?  The sched-O1-H6 patch?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
