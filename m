Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266921AbTGKVtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266919AbTGKVtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:49:03 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57528
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266885AbTGKVqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:46:00 -0400
Subject: Re: PATCH: AC97 updates from 2.4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Liam Girdwood <liam@exize.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Liam Girdwood <liam.girdwood@wolfsonmicro.com>
In-Reply-To: <1057955207.3607.25.camel@odin>
References: <200307111809.h6BI9Zd5017272@hraefn.swansea.linux.org.uk>
	 <20030711184706.GD16037@gtf.org>  <1057955207.3607.25.camel@odin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057960677.20636.56.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 22:57:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-11 at 21:26, Liam Girdwood wrote:
> I would eventually like to see something similar to this in ALSA. 
> 
> I wrote the touchscreen driver plugin and an ALSA AC97 plugin API will
> probably be needed before this time next year to keep Linux up to date
> in the PDA/Tablet/Portable space. Eventually we may need an I2S and/or
> Azalia (next gen audio) API layer for such devices.
> 
> I intend to speak to the ALSA guys as soon as the OSS plugin driver has
> stabilised. 

It would be great if we can get the same plugin API for both, although that
may be trickier since the mixer side is quite different

