Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280314AbRJaRLC>; Wed, 31 Oct 2001 12:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280306AbRJaRKp>; Wed, 31 Oct 2001 12:10:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6673 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280313AbRJaRJh>; Wed, 31 Oct 2001 12:09:37 -0500
Subject: Re: which cpu?
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Wed, 31 Oct 2001 17:16:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0110311735170.27680-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Oct 31, 2001 05:38:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yyyg-0004Mb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> which cpu should I compile for, when having a so-called "National SC1200
> 32bit, 266MHz, x86-compatible processor with integrated TV video
> processor"?

Assuming its stil the same old nat semi geode rebadge with new numbers and
I guess new features - 586 without TSC - actually the TSC might work on the
one you have but the kernel wont trust it
