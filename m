Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129801AbQKTS21>; Mon, 20 Nov 2000 13:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129775AbQKTS2R>; Mon, 20 Nov 2000 13:28:17 -0500
Received: from 3dyn88.com21.casema.net ([212.64.94.88]:60679 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129289AbQKTS2H>;
	Mon, 20 Nov 2000 13:28:07 -0500
Date: Mon, 20 Nov 2000 19:51:45 +0100
From: bert hubert <ahu@ds9a.nl>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Remove tq_scheduler
Message-ID: <20001120195145.A16245@home.ds9a.nl>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3A15FD94.F19DA5F0@uow.edu.au> <E13xuPV-0003pc-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <E13xuPV-0003pc-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 20, 2000 at 05:07:14PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2000 at 05:07:14PM +0000, Alan Cox wrote:
> >   The patch against test11-pre7 (1043 lines) is at
> > 
> > 	http://www.uow.edu.au/~andrewm/linux/tq_scheduler.patch
> > 
> >   It affects the following files:
> 
> Andrew, can you put your patches on a properly configured site.  The site
> admins have all ICMP packets blocked on www.uow.edu.au so you are a PMTU 
> blackhole and unreachable via my tunnel.

Or configure your host to do MSS Clamping. I have a similar situation over
here and no problems.

Regards,

bert hubert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
