Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129364AbRB1XgP>; Wed, 28 Feb 2001 18:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRB1XgG>; Wed, 28 Feb 2001 18:36:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63753 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129364AbRB1Xfq>; Wed, 28 Feb 2001 18:35:46 -0500
Subject: Re: i2o & Promise SuperTrak100
To: david2@maincube.net (David Priban)
Date: Wed, 28 Feb 2001 23:38:31 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <MPBBILLJAONHMANIJOPDAEGGFMAA.david2@maincube.net> from "David Priban" at Feb 28, 2001 03:11:30 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YGAz-0006k8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I enable DRIVERDEBUG in i2o_core.c it makes the freeze to go away and
> kernel
> loads just fine. I do get bunch of I/O errors on mounted array but this may
> be due to crappy HD's I'm using for testing.

Umm that sounds like it might be timing. That could be a pain

