Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317570AbSGTXFw>; Sat, 20 Jul 2002 19:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317571AbSGTXFw>; Sat, 20 Jul 2002 19:05:52 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:33266 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317570AbSGTXFw>; Sat, 20 Jul 2002 19:05:52 -0400
Subject: Re: 2.4.18-2.4.19-rc1-ac4 + Promise SX6000 + i2o
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amith Varghese <amith@xalan.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1027200088.3d39d4587cc66@192.168.101.69>
References: <1026941364.4547.91.camel@viper> 
	<1026966681.4537.119.camel@viper>  <1027048267.4537.185.camel@viper>
	<1027197568.16818.23.camel@irongate.swansea.linux.org.uk> 
	<1027200088.3d39d4587cc66@192.168.101.69>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 01:21:04 +0100
Message-Id: <1027210864.16818.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o        Newer SX6000 has PDC20276 chips. Handle this 
> 
> If that is the case, I guess I have to use the promise drivers.  However, i'll 
> offer free beer if anyone can help me get the i2o driver to work :)

The current -ac tree does handle this, but the i2o on the SX6000 fails
anyway. At the moment I have no timescale or plan to address this.

