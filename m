Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSHOMGP>; Thu, 15 Aug 2002 08:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316842AbSHOMGP>; Thu, 15 Aug 2002 08:06:15 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:32507 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316838AbSHOMGO>; Thu, 15 Aug 2002 08:06:14 -0400
Subject: Re: promise ultra 133 tx2 lets system standby during use...?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Munck Steenholdt <tmus@get2net.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208151111.NAA01608@eday-fe3.tele2.ee>
References: <200208151111.NAA01608@eday-fe3.tele2.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Aug 2002 13:08:35 +0100
Message-Id: <1029413315.29812.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-15 at 12:11, Thomas Munck Steenholdt wrote:
> That would be in the BIOS right (or could it be done from linux) ?

If you know the chipset and the docs are around then its actually
normally very easy to poke from Linux too. Depends on the chipset

> Would apm=off bypass this kind of thing?

It may do yes

