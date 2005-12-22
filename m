Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVLVLP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVLVLP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 06:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVLVLP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 06:15:59 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:24363 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932159AbVLVLP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 06:15:59 -0500
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>,
       Ricardo Cerqueira <v4l@cerqueira.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
In-Reply-To: <20051222005941.GK3917@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051220131810.GB6789@stusta.de>
	 <20051220155216.GA19797@master.mivlgu.local>
	 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>
	 <20051220191412.GA4578@stusta.de> <1135110930.7822.18.camel@localhost>
	 <20051222005941.GK3917@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 22 Dec 2005 09:15:47 -0200
Message-Id: <1135250147.17758.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qui, 2005-12-22 às 01:59 +0100, Adrian Bunk escreveu:
 
> > 	This patch should fix alsa-oss incompatibilities when both are linked
> > as module. It will also require either -oss or -alsa if it is statically
> > linked.
> > 
> > 	It doesn't address the OOPS because of sound late init.
> > 
> > 	Adrian,
> > 
> > 	Please test and give us some feedback.
> 
> It works and looks good.
> 
> Can we get this patch into 2.6.15?
	I've sent today to Linus for him to pull for 2.6.15.

Cheers, 
Mauro.

