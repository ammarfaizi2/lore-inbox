Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132138AbRAKPyz>; Thu, 11 Jan 2001 10:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132315AbRAKPyp>; Thu, 11 Jan 2001 10:54:45 -0500
Received: from mail-oak-3.pilot.net ([198.232.147.18]:27055 "EHLO
	mail03-oak.pilot.net") by vger.kernel.org with ESMTP
	id <S132138AbRAKPyc>; Thu, 11 Jan 2001 10:54:32 -0500
Message-ID: <973C11FE0E3ED41183B200508BC7774C9CC991@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <twoller@crystal.cirrus.com>
To: "'David Ford'" <david@linux.com>, LKML <linux-kernel@vger.kernel.org>,
        nils@kernelconcepts.de
Subject: RE: cs46xx only works as a module still (post 2.4.0)
Date: Thu, 11 Jan 2001 09:53:24 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

appreciate the info.  i'll look at it.  
glad it works as a module :)
tom

> -----Original Message-----
> From:	David Ford [SMTP:david@linux.com]
> Sent:	Wednesday, January 10, 2001 11:35 PM
> To:	LKML; nils@kernelconcepts.de; twoller@crystal.cirrus.com
> Subject:	cs46xx only works as a module still (post 2.4.0)
> 
> Just a friendly reminder, the cs46xx driver only works if it's compiled
> as a module.  If it's static, it never gets activated on boot.
> 
> -d
>  << File: Card for David Ford >> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
