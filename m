Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282990AbRLDJhE>; Tue, 4 Dec 2001 04:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282976AbRLDJgp>; Tue, 4 Dec 2001 04:36:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57360 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283018AbRLDJg3>; Tue, 4 Dec 2001 04:36:29 -0500
Subject: Re: Linux/Pro  -- clusters
To: linux-kernel@vger.kernel.org
Date: Tue, 4 Dec 2001 09:45:34 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20011204103010.A30650@stud.ntnu.no> from "=?iso-8859-1?Q?Thomas_Lang=E5s?=" at Dec 04, 2001 10:30:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BC8s-0001Tf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox:
> > >    a SCSI device layer that isn't three half-finished clean-ups
> > Beginning (at last)
> 
> So there's someone fixing the SCSI-layer code now?   (It's marked as
> unmaintained in the MAINTAINERS-file for 2.4-kernels, at least)

Take a look at the 2.5 code and you'll notice various bits of old cruft
are vanishing rapidly (old eh support, clustering gloop etc)
