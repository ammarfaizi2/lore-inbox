Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263318AbRGBKSt>; Mon, 2 Jul 2001 06:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263329AbRGBKSj>; Mon, 2 Jul 2001 06:18:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22792 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263318AbRGBKSX>; Mon, 2 Jul 2001 06:18:23 -0400
Subject: Re: Intel SRCU3-1 RAID (I2O) and 2.4.5-ac18
To: pt@procomnet2.prograine.net
Date: Mon, 2 Jul 2001 11:18:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0107021001060.20976-100000@procomnet2.prograine.net> from "pt@procomnet2.prograine.net" at Jul 02, 2001 10:11:00 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15H0mI-0005hh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ALso set up the i2o cgi tools and see why
> > the device wants to talk to you
> 
> Tried to setup the Intel tools just as I did it before and I get
> only an "Error: could not open I2O system" in the browser under the
> RH-supplied kernel. I will keep trying to resolve this problem.

modprobe i2o_config 

may be needed

