Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261952AbTCLUg4>; Wed, 12 Mar 2003 15:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261980AbTCLUg4>; Wed, 12 Mar 2003 15:36:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50631
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261952AbTCLUgy>; Wed, 12 Mar 2003 15:36:54 -0500
Subject: Re: 2.5.64: i2c-proc kills machine at boot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?unknown-8bit?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030312161451.GA30741@wohnheim.fh-wedel.de>
References: <20030311104721.GA401@elf.ucw.cz>
	 <20030312125631.GA27966@wohnheim.fh-wedel.de>
	 <1047484999.22696.7.camel@irongate.swansea.linux.org.uk>
	 <20030312161451.GA30741@wohnheim.fh-wedel.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047506134.23730.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Mar 2003 21:55:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 16:14, =?unknown-8bit?Q?J=F6rn?= Engel wrote:
> On Wed, 12 March 2003 16:03:19 +0000, Alan Cox wrote:
> > 
> > > It also isn't listed in the current MAINTAINERS file. Is i2o currently
> > > unmaintained?
> > 
> > Its kind of mine. Maintained is an overly strong word for it however, but I 
> > do take patches 8)
> 
> All right. The following is against 2.5.64, compiles and reduces the
> worst stack offender to 0x190 bytes. It is untested though, I don't
> have any hardware for it.

I have hardware however so I'll give it a check

