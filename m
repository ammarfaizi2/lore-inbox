Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132418AbRCaPJp>; Sat, 31 Mar 2001 10:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132421AbRCaPJ1>; Sat, 31 Mar 2001 10:09:27 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:55565 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132418AbRCaPJI>; Sat, 31 Mar 2001 10:09:08 -0500
Message-Id: <200103311508.f2VF8Ns50952@aslan.scsiguy.com>
To: "Earle Nietzel" <nietzel@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Minor 2.4.3 Adaptec Driver Problems 
In-Reply-To: Your message of "Sat, 31 Mar 2001 12:42:38 PST."
             <003001c0ba23$217f81c0$1401a8c0@nietzel> 
Date: Sat, 31 Mar 2001 08:08:23 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I just got 2.4.3 up a running (on Abit BP6 Dual Celeron ) and
>it reorderd my SCSI id's. Take a look. I don't like that my ZIP drive
>becomes sda because if I ever remove it then I'll @#$% my harddrive dev
>mappings again and have to change them again. Adaptec Driver 6.1.5
>:-(

Upgrade to version 6.1.8 of the aic7xxx driver from here.  This was
fixed just after 6.1.5 was released:

http://people.FreeBSD.org/~gibbs/linux

Use the 2.4.3-pre6 patch.

--
Justin
