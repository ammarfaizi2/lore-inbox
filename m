Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTDWW6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264293AbTDWW6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:58:17 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34946
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264292AbTDWW6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:58:16 -0400
Subject: Re: [Motion] Re: IDE corruption during heavy bt878-induced interr
	upt load [LKM]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: joe briggs <jbriggs@briggsmedia.com>
Cc: David Brodbeck <DavidB@mail.interclean.com>,
       "'motion@lists.frogtown.com'" <motion@pdx.frogtown.com>,
       andras@t-online.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       motion@frogtown.com
In-Reply-To: <200304231813.46892.jbriggs@briggsmedia.com>
References: <C823AC1DB499D511BB7C00B0D0F0574C583D23@serverdell2200.interclean.com>
	 <200304231813.46892.jbriggs@briggsmedia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051135875.2062.101.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2003 23:11:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-23 at 23:13, joe briggs wrote:
> Is this true??? Does onboard IDE controllers appear and work the same way as 
> IDE or PCI controllers with respect to IRQ, DMA, and memory access?

They appear to. Most of them nowdays are wired directly to the
north/southbridge link for performance.

