Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287798AbSAAKdR>; Tue, 1 Jan 2002 05:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287801AbSAAKdI>; Tue, 1 Jan 2002 05:33:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9491 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287798AbSAAKcy>; Tue, 1 Jan 2002 05:32:54 -0500
Subject: Re: Why would a valid DVD show zero files on Linux?
To: bodnar42@phalynx.dhs.org (Ryan Cumming)
Date: Tue, 1 Jan 2002 10:43:17 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <E16LMBq-0007Lw-00@phalynx> from "Ryan Cumming" at Jan 01, 2002 02:30:38 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LMO5-0008H5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > have a UDF file system on them that isnt interesting. Some DVD's have an
> > ISO fs that isnt interesting.
> 
> It seems like it should be up to userspace to first try UDF for DVDs, and 
> first try iso9660 for CDs.

Guess what. You can tell user space to do that

