Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030468AbWGaV3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbWGaV3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 17:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbWGaV3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 17:29:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64968 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751356AbWGaV3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 17:29:20 -0400
Subject: Re: [PATCH] Kconfig for radio cards to allow VIDEO_V4L1_COMPAT
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1154302828.2318.9.camel@localhost.localdomain>
References: <9e4733910606251040v62675399gdfe438aaac691a5a@mail.gmail.com>
	 <1151327213.3687.13.camel@praia>
	 <9e4733910606260855kf2e57ado5c69d8295d1be5@mail.gmail.com>
	 <1151341122.13794.2.camel@praia>
	 <1154302828.2318.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 31 Jul 2006 18:28:16 -0300
Message-Id: <1154381296.2506.4.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Seg, 2006-07-31 às 00:40 +0100, Alan Cox escreveu:
> Ar Llu, 2006-06-26 am 13:58 -0300, ysgrifennodd Mauro Carvalho Chehab:
> > those devices are really obsolete hardware and none of the current V4L
> > developers have those boards for testing. Do you have any of those
> > devices? Can you help porting it to V4L2?
> 
> The USB radio is probably the only one that matters, and I do have one
> of those.
Are you referring to "D-Link USB FM radio support"? I'll seek some time
to convert it and ask you to test it. Shouldn't be hard.
> 
> 
Cheers, 
Mauro.

