Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267838AbTB1MJx>; Fri, 28 Feb 2003 07:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267841AbTB1MJx>; Fri, 28 Feb 2003 07:09:53 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7569
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267838AbTB1MJv>; Fri, 28 Feb 2003 07:09:51 -0500
Subject: Re: Promise PDC 20376
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Monniaux <David.Monniaux@ens.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E5ED648.5080509@ens.fr>
References: <3E5ED648.5080509@ens.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046438573.16599.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Feb 2003 13:22:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 03:23, David Monniaux wrote:
> Is anybody (Andre?) working on a driver for the Promise PDC 20376 Serial 
> ATA / RAID controller?

No. The SII is supported and the HPT with SATA bridges should work. Some
informal discussion has occurred with two other vendors who will be releasing
SATA products in time.

It is probably possible to reverse engineer the 20376 since I suspect it will
behave like the older devices but with the registers memory mapped.

