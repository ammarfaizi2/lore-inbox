Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262310AbTCMSR4>; Thu, 13 Mar 2003 13:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262424AbTCMSR4>; Thu, 13 Mar 2003 13:17:56 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:21177 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S262310AbTCMSRz>; Thu, 13 Mar 2003 13:17:55 -0500
Message-ID: <20030313182812.7679.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: axboe@suse.de, jeremy@goop.org
Cc: linux-kernel@vger.kernel.org
Date: Thu, 13 Mar 2003 19:28:12 +0100
Subject: Re: 2.5.64-mm6: kernel BUG at kernel/timer.c:155!
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Jens Axboe <axboe@suse.de> 
Date: 	Thu, 13 Mar 2003 18:54:54 +0100 
To: Jeremy Fitzhardinge <jeremy@goop.org> 
Subject: Re: 2.5.64-mm6: kernel BUG at kernel/timer.c:155! 
 
> On Thu, Mar 13 2003, Jeremy Fitzhardinge wrote: 
> > I was reading back a freshly burned CD from my shiny new Plexwriter 
> > 48/24/48A.  I'm using ide-scsi, so this is an iso9660 filesystem mounted 
>  
> out of curiousity, why? ide-cd should work much better than ide-scsi in 
> 2.5, if it doesn't I'd like to know. 
 
There are still userspace CD burning programs that do not yet 
support ATAPI burning interface. "cdrecord" does support it, 
but K3B (a KDE burning frontend to cdrecord and company) 
only works with SCSI or IDE-SCSI burners (well, or at least 
I have been unable to convince it to use the ATAPI interface 
to my Sony burner). 
 
Best regards, 
 
   Felipe 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
