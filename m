Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319675AbSIMPJD>; Fri, 13 Sep 2002 11:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319676AbSIMPJD>; Fri, 13 Sep 2002 11:09:03 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:9469 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319675AbSIMPJB>; Fri, 13 Sep 2002 11:09:01 -0400
Subject: Re: Possible bug and question about ide_notify_reboot in
	drivers/ide/ide.c (2.4.19)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020913151037.GM28541@louise.pinerecords.com>
References: <20020913023744.78077.qmail@web40510.mail.yahoo.com>
	<1031922553.9056.18.camel@irongate.swansea.linux.org.uk> 
	<20020913151037.GM28541@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 13 Sep 2002 16:14:57 +0100
Message-Id: <1031930097.9679.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-13 at 16:10, Tomas Szepe wrote:
> > > I have
> > > to go into the BIOS and force auto-detect to wake them back up. I've removed the "standby"
> > > code and things seem to be functioning normally. I have an Epox 8K7A motherboard with two
> > > Maxtor Hard drives (model 5T040H4).
> > 
> > Congratulations your BIOS sucks 8)
> 
> Alan, obviously this should be made into a config option.

I dont think so. We can't go around with 15,000 "My bios cant XYZ"
options and "My PCI bus ...".

