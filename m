Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292021AbSBTRAp>; Wed, 20 Feb 2002 12:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292027AbSBTRAf>; Wed, 20 Feb 2002 12:00:35 -0500
Received: from magic.adaptec.com ([208.236.45.80]:17308 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S292021AbSBTRAU>; Wed, 20 Feb 2002 12:00:20 -0500
Message-ID: <F8D30FF32B23D61198B9009027D61DB32FC1D8@otcexc01.otc.adaptec.com>
From: "Bonds, Deanna" <Deanna_Bonds@adaptec.com>
To: "'Jordan Breeding'" <ledzep37@attbi.com>, linux-kernel@vger.kernel.org
Subject: RE: Adaptec dpt_i20.c broken in 2.5?
Date: Wed, 20 Feb 2002 11:59:06 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-15"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will be getting to this soon.  

Deanna

> -----Original Message-----
> From: Jordan Breeding [mailto:ledzep37@attbi.com]
> Sent: Wednesday, February 20, 2002 6:38 AM
> To: linux-kernel@vger.kernel.org
> Subject: Adaptec dpt_i20.c broken in 2.5?
> 
> 
> I will most likely be purchasing a system soon which will 
> make use of an
> Adaptec Zero Channel raid card and so it will require the use of the
> dpt_i2o Adaptec driver.  However, currently in 2.5.5 if you select
> Adaptec i2o to be compiled it gives an error caused by this line:
> 
> #error Please convert me to Documentation/DMA-mapping.txt
> 
> Will this be fixed in a -pre version any time soon?  Thanks 
> for any info
> on the situation with this scsi driver.
> 
> Jordan
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
