Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSHVRzB>; Thu, 22 Aug 2002 13:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSHVRzB>; Thu, 22 Aug 2002 13:55:01 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:56563 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315267AbSHVRzA>; Thu, 22 Aug 2002 13:55:00 -0400
Subject: Re: ServerWorks OSB4 in impossible state
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Gonzalo Servat <gonzalo@unixpac.com.au>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020822164527.GA11488@louise.pinerecords.com>
References: <Pine.LNX.4.10.10208220143440.11626-100000@master.linux-ide.org>
	<1030017756.9866.74.camel@biker.pdb.fsc.net> 
	<20020822164527.GA11488@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 22 Aug 2002 18:59:30 +0100
Message-Id: <1030039170.3151.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 17:45, Tomas Szepe wrote:
> AFAIK 2.4.18 as well as 2.4.19-preEARLY seemed to work flawlessly w/ OSB4
> even in DMA modes. How's the code there then? Is it dangerous to use?

Most of them work all the time (most OSB4, all CSB5. all CSB6)
All of them work all the time with most drives
Some of them do horrible things in UDMA with some drives (timing
patterns I guess)

All of the OSB4 do MWDMA fine.
