Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132478AbRCaTV7>; Sat, 31 Mar 2001 14:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132483AbRCaTVt>; Sat, 31 Mar 2001 14:21:49 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:56335 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132478AbRCaTVo>; Sat, 31 Mar 2001 14:21:44 -0500
X-Apparently-From: <nietzel@yahoo.com>
Message-ID: <000701c0ba63$58a96900$1401a8c0@nietzel>
Reply-To: "Earle Nietzel" <nietzel@yahoo.com>
From: "Earle Nietzel" <nietzel@yahoo.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>
In-Reply-To: <200103311508.f2VF8Ns50952@aslan.scsiguy.com>
Subject: Re: Minor 2.4.3 Adaptec Driver Problems 
Date: Sat, 31 Mar 2001 20:21:24 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >I just got 2.4.3 up a running (on Abit BP6 Dual Celeron ) and
> >it reorderd my SCSI id's. Take a look. I don't like that my ZIP drive
> >becomes sda because if I ever remove it then I'll @#$% my harddrive dev
> >mappings again and have to change them again. Adaptec Driver 6.1.5
> >:-(
>
> Upgrade to version 6.1.8 of the aic7xxx driver from here.  This was
> fixed just after 6.1.5 was released:
>
> http://people.FreeBSD.org/~gibbs/linux
>
> Use the 2.4.3-pre6 patch.

I upgraded to the level 6.1.8 but It is still booting the scsi generic(sg)
driver before my hard drives. I have verified that I am using Rev 6.1.8 from
dmesg.

I did applied patch 2.4.3-pre6 on a stock 2.4.3 kernel.

ideas?
Earle
(please email me directly)



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

