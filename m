Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbTA1Kks>; Tue, 28 Jan 2003 05:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbTA1Kks>; Tue, 28 Jan 2003 05:40:48 -0500
Received: from tao.natur.cuni.cz ([195.113.56.1]:36616 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id <S265132AbTA1Kkr>;
	Tue, 28 Jan 2003 05:40:47 -0500
X-Obalka-From: mmokrejs@natur.cuni.cz
Date: Tue, 28 Jan 2003 11:50:01 +0100 (CET)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Edward Tandi <ed@efix.biz>
cc: Jens Axboe <axboe@suse.de>, Ross Biro <rossb@google.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre3 kernel crash
In-Reply-To: <1043699262.2696.7.camel@wires.home.biz>
Message-ID: <Pine.OSF.4.51.0301281149100.124440@tao.natur.cuni.cz>
References: <Pine.OSF.4.51.0301271632230.49659@tao.natur.cuni.cz> 
 <3E356403.9010805@google.com>  <Pine.OSF.4.51.0301271813230.57372@tao.natur.cuni.cz>
  <20030127192327.GD889@suse.de> <1043699262.2696.7.camel@wires.home.biz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, Edward Tandi wrote:

> FYI It works!
>
> > ===== drivers/ide/ide-dma.c 1.7 vs edited =====
> > --- 1.7/drivers/ide/ide-dma.c	Wed Nov 20 18:46:24 2002
> > +++ edited/drivers/ide/ide-dma.c	Mon Jan 27 20:22:06 2003

Hi,
  yes, for me too. Thanks! BTW: Someone will have a look who removed that
part and what else got removed too. ;)

-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
