Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288845AbSANSuc>; Mon, 14 Jan 2002 13:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288809AbSANSsr>; Mon, 14 Jan 2002 13:48:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24070 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288801AbSANSsf>; Mon, 14 Jan 2002 13:48:35 -0500
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
To: esr@thyrsus.com
Date: Mon, 14 Jan 2002 19:00:13 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), eli.carter@inet.com (Eli Carter),
        Michael.Lazarou@etl.ericsson.se ("Michael Lazarou (ETL)"),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020114132618.G14747@thyrsus.com> from "Eric S. Raymond" at Jan 14, 2002 01:26:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QCL7-0002Xs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it OK in your world that Aunt Tillie is dependent on a distro maker?  Is
> it OK that she never gets to have a kernel compiled for anything above the
> least-common-denominator chip?  

The two don't follow. 

The goal of a typical end user is "make it work, make it go away and do what
it did last week". Random mechanics hating car owners don't do engine tuning
jobs or fit turbochargers.

Secondly we've established we can pick the right CPU for the kernel reliably
that is seperate to modules. 

Thirdly building a lot of stuff modular is the right choice anyway - in the
world of hot plugging and USB Grandma is not going to want to recompile her
kernel because she bought a new trackball to boost her quake score. 

Alan
