Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSHKDbo>; Sat, 10 Aug 2002 23:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSHKDbo>; Sat, 10 Aug 2002 23:31:44 -0400
Received: from mta05bw.bigpond.com ([139.134.6.95]:52162 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S317589AbSHKDbn>; Sat, 10 Aug 2002 23:31:43 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Pete de Zwart <dezwart@froob.net>
Subject: Re: 2.4.19: drivers/usb/printer.c usblpX on fire
Date: Sun, 11 Aug 2002 13:30:14 +1000
User-Agent: KMail/1.4.5
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
References: <200208092200.RAA34736@tomcat.admin.navo.hpc.mil> <200208111052.25488.bhards@bigpond.net.au> <20020811013639.GG27819@niflheim>
In-Reply-To: <20020811013639.GG27819@niflheim>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208111330.15129.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 11 Aug 2002 11:36, Pete de Zwart wrote:
> Yeah, that makes sense, it's not the kernel's job to take care of the
> printers status beyond the basics.
>
> Make the printer drivers like a pseudo-micro-kernel, have the basic printer
> operations done in the kernel and have the rest of the functionality farmed
> out to individual printer modules.
WTF?

> Ignoring the above, where should the functionality for the extended printer
> operations reside?
Depends on printer service. Irrelevant to kernel.

> In the print spooler? A separate process that deals with a bunch of
> printers?
Depends on printer service.

> If this is going off-topic for LKML where would be a better place to
> discuss this?
ML for whatever printer service you want to use.


- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9VdpGW6pHgIdAuOMRAjivAJ48K4aWrOrUo9MqOxbFAAlPvOBqAQCfSMAS
ifgR+wFLwQIjH7SZNPS1Nqc=
=s5IL
-----END PGP SIGNATURE-----

