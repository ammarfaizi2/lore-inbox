Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266150AbUFUH11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266150AbUFUH11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 03:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266148AbUFUH10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 03:27:26 -0400
Received: from AGrenoble-152-1-39-8.w82-122.abo.wanadoo.fr ([82.122.133.8]:54696
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S266155AbUFUH1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 03:27:03 -0400
Subject: Re: Stop the Linux kernel madness
From: Xavier Bestel <xavier.bestel@free.fr>
To: Hannu Savolainen <hannu@opensound.com>
Cc: 4Front Technologies <dev@opensound.com>,
       David Lang <david.lang@digitalinsight.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0406210933470.26543@zeus.compusonic.fi>
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay>
	 <40D23701.1030302@opensound.com>
	 <1087573691.19400.116.camel@winden.suse.de> <40D32C1D.80309@opensound.com>
	 <20040618190257.GN14915@schnapps.adilger.int>
	 <40D34CB2.10900@opensound.com>
	 <200406181940.i5IJeBDh032311@turing-police.cc.vt.edu>
	 <Pine.LNX.4.60.0406181326210.3688@dlang.diginsite.com>
	 <Pine.LNX.4.58.0406191148570.30038@zeus.compusonic.fi>
	 <Pine.LNX.4.60.0406201506360.6470@dlang.diginsite.com>
	 <40D636EA.7090704@opensound.com>
	 <Pine.LNX.4.58.0406210933470.26543@zeus.compusonic.fi>
Content-Type: text/plain
Date: Mon, 21 Jun 2004 09:25:37 +0200
Message-Id: <1087802737.31390.3.camel@speedy.priv.grenoble.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-21 at 10:07 +0300, Hannu Savolainen wrote:

> What would the modules directory look like if the next generation devices
> get included there too? Or if all the drivers for currently
> unsupported defence, telecom, aviation, instrumentation and other special
> purpose devices get included in the kernel source tree?

Having more maintained drivers in the kernel can't be a bad thing. For a
standard desktop or server, having all these drivers installed
under /lib/modules is also beneficial. Makers of embedded distributions
will continue to heavily customize their kernel and applications, as
they always did.

	Xav

