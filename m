Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292584AbSB0Psf>; Wed, 27 Feb 2002 10:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292586AbSB0PsY>; Wed, 27 Feb 2002 10:48:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23309 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292584AbSB0PsJ>; Wed, 27 Feb 2002 10:48:09 -0500
Subject: Re: [Emu10k1-devel] Re: Emu10k1 SPDIF passthru doesn't work if
To: rui.p.m.sousa@clix.pt (Rui Sousa)
Date: Wed, 27 Feb 2002 16:02:48 +0000 (GMT)
Cc: german@piraos.com (German Gomez Garcia),
        jcm@netcabo.pt (=?ISO-8859-1?Q?Jos=E9?= Carlos Monteiro),
        linux-kernel@vger.kernel.org, emu10k1-devel@lists.sourceforge.net,
        steve@math.upatras.gr (Steve Stavropoulos),
        d.bertrand@ieee.org (Daniel Bertrand), dledford@redhat.com
In-Reply-To: <Pine.LNX.4.44.0202271551370.1215-100000@sophia-sousar2.nice.mindspeed.com> from "Rui Sousa" at Feb 27, 2002 03:58:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16g6XY-0004v8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The most bizzare is that in a machine with 192Mib of memory but with a=20
> kernel compiled with HIGHMEM support I see the same type of problems.

Change of size in a structure or type ?
