Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262959AbSKMWOG>; Wed, 13 Nov 2002 17:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262981AbSKMWOG>; Wed, 13 Nov 2002 17:14:06 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:65194 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262959AbSKMWOG>; Wed, 13 Nov 2002 17:14:06 -0500
Subject: Re: [bug] i2o_lan modules fails to build in 2.5.47
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anthony Murray <murrant@bvu.edu>
Cc: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <sdd26bdb.016@ngw.bvu.edu>
References: <sdd26bdb.016@ngw.bvu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 22:46:27 +0000
Message-Id: <1037227587.11996.201.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 21:12, Anthony Murray wrote:
> Hi, I am hvaing trouble building the i2o_lan module for 2.5.47.  I have a 3com 905 net card and built support for it into the kernel. Here is the errors:


i2o_lan is (like the word wrap on your mailer) broken. At the moment
there are no plans to do anything but expire the driver for 2.6. There
isn't any extant i2o_lan specific hardware to my knowledge.

Alan

