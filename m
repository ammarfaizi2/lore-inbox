Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317641AbSGUFp0>; Sun, 21 Jul 2002 01:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317642AbSGUFp0>; Sun, 21 Jul 2002 01:45:26 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:7430 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317641AbSGUFp0>; Sun, 21 Jul 2002 01:45:26 -0400
Date: Sat, 20 Jul 2002 22:43:56 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Amith Varghese <amith@xalan.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-2.4.19-rc1-ac4 + Promise SX6000 + i2o
In-Reply-To: <1027210864.16818.43.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10207202242520.23502-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't drink, I have enough problems keeping friends sober!
Make it a case of Coca-Cola (tm) and you are on!


Andre Hedrick
LAD Storage Consulting Group

On 21 Jul 2002, Alan Cox wrote:

> > o        Newer SX6000 has PDC20276 chips. Handle this 
> > 
> > If that is the case, I guess I have to use the promise drivers.  However, i'll 
> > offer free beer if anyone can help me get the i2o driver to work :)
> 
> The current -ac tree does handle this, but the i2o on the SX6000 fails
> anyway. At the moment I have no timescale or plan to address this.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

