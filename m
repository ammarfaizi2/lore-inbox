Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263073AbTCWOiQ>; Sun, 23 Mar 2003 09:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263071AbTCWOiQ>; Sun, 23 Mar 2003 09:38:16 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:47818 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S263073AbTCWOiN>; Sun, 23 Mar 2003 09:38:13 -0500
Message-ID: <20030323144914.8426.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: baldrick@wanadoo.fr, "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>,
       alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Date: Sun, 23 Mar 2003 15:49:14 +0100
Subject: Re: 2.5 BK boot hang after ide
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Duncan Sands <baldrick@wanadoo.fr> 
Date: Sun, 23 Mar 2003 15:34:50 +0100 
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>, alan@redhat.com 
Subject: Re: 2.5 BK boot hang after ide 
 
> > I'm experiencing exactly the same as you: 2.5 won't 
> > continue past IDE. I've tried 2.5.65-ac3, 2.5.65-bk3 
> > and 2.5.65-mm4. All of them fail at the same point. 
> > I've tried using ACPI, APM, disabling preempt, TCQ, 
> > enabling SysRq support, but had no luck. 
> > 
> > The machine is a Pentium 4 2.0Gz, with a QDI 
> > PlatiniX 2D/533-A (i845E), 2 UDMA100 disks 
> > (Seagate ST380021A 80GB and IBM-DTLA-307030 
> > 20GB), a Pioneer DVD-ROM and Sony CRX185E3). 
>  
> 2.5 BK worked for me two days ago, i.e. before Alan's 
> latest IDE changes went in.  Did any previous version 
> work for you? 
>  
Yes, the last one I tried, before trying 2.5.65, was vanilla 
2.5.64, if my memory serves me well :-) 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
