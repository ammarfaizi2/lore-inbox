Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266690AbSKOUrP>; Fri, 15 Nov 2002 15:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266701AbSKOUrP>; Fri, 15 Nov 2002 15:47:15 -0500
Received: from gzp11.gzp.hu ([212.40.96.53]:65030 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id <S266690AbSKOUrO>;
	Fri, 15 Nov 2002 15:47:14 -0500
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: Re: Status of the CMD680 IDE driver
References: <73fe.3dd52324.188a7@gzp1.gzp.hu> <73fe.3dd52324.188a7@gzp1.gzp.hu> <1037383237.19971.49.camel@irongate.swansea.linux.org.uk>
Organization: Who, me?
User-Agent: tin/1.5.15-20021115 ("Spiders") (UNIX) (Linux/2.4.20-rc1 (i686))
Message-ID: <39d7.3dd55ef1.9a92d@gzp1.gzp.hu>
Date: Fri, 15 Nov 2002 20:54:09 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk>:

|> Seems like it is in the later 2.4, but removed from the -ac
|> line, and missing from the 2.5 tree.
| 
| siimage driver drives the CMD680 and the SATA SII3112 version of the
| chip.

Thanks. In this case the config help file for CONFIG_BLK_DEV_CMD64X
should be fixed.

