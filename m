Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTFJLyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 07:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTFJLyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 07:54:47 -0400
Received: from ausadmmsrr502.aus.amer.dell.com ([143.166.83.89]:59409 "HELO
	AUSADMMSRR502.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S262456AbTFJLyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 07:54:44 -0400
X-Server-Uuid: 586817ae-3c88-41be-85af-53e6e1fe1fc5
Message-ID: <0D2092D75155D511881100B0D0D00F3902D32E66@uppxmbl101.se.dell.com>
From: Martin_List-Petersen@Dell.com
To: Robert.L.Harris@rdlg.net
cc: m.watts@mrw.demon.co.uk, linux-kernel@vger.kernel.org
Subject: RE: PERC4-DI?
Date: Tue, 10 Jun 2003 07:06:52 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 12FB15B32336584-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a list:
Perc 2, Perc 3/Si, Perc 3/Di - Adaptec
Perc 2/SC, Perc 3/SC, Perc 3/DC, Perc 3/QC, Perc 4/Di - AMI / LSI

The only server out there with a Perc 4/Di currently is the Dell PowerEdge
2600. The PE2650 has a PERC 3/Di instead (Adaptec).

Have fun.

/Martin

> -----Original Message-----
> From: Mark Watts [mailto:m.watts@mrw.demon.co.uk]
> Sent: den 7 juni 2003 13:05
> To: Linux-Kernel
> Subject: Re: PERC4-DI?
> 
> 
> On Friday 06 Jun 2003 5:37 pm, Robert L. Harris wrote:
> > My company is looking at buying some machines with 
> "PERC4-DI" SCSI RAID
> > controllers.  Poking around the .config file I'm not 
> finding anything
> > related to this.  Anyone know off the top of their heads what driver
> > would be used for this controller, any known catastrophic bugs, etc?
> 
> If its anything like the PERC 3 cards, it could be anything 
> from an LSI 
> through to an Adaptec card. (PERC = PowerEdge Raid Controler).
> 
> I haven't found any major issues with any of them yet, but we 
> don't tend to 
> push them as hard as others here - we mainly use them in webservers.
> 
> Mark.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

