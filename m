Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263720AbTEFNpl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbTEFNpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:45:41 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10624
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263720AbTEFNpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:45:40 -0400
Subject: Re: ISDN massive packet drops while DVD burn/verify
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: kkeil@suse.de, kai@tp1.ruhr-uni-bochum.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030506143902.2b3fcecd.skraw@ithnet.com>
References: <20030416151221.71d099ba.skraw@ithnet.com>
	 <Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu>
	 <20030419193848.0811bd90.skraw@ithnet.com>
	 <1050789691.3955.17.camel@dhcp22.swansea.linux.org.uk>
	 <20030505164653.GA30015@pingi3.kke.suse.de>
	 <20030505192652.7f17ea9e.skraw@ithnet.com>
	 <1052218412.28797.18.camel@dhcp22.swansea.linux.org.uk>
	 <20030506143902.2b3fcecd.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052225795.1201.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 13:56:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 13:39, Stephan von Krawczynski wrote:
>  HDIO_GET_MULTCOUNT failed: Invalid argument
>  IO_support   =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  BLKRAGET failed: Invalid argument
>  HDIO_GETGEO failed: Invalid argument
>  
> 
> using_dma means it's using dma for transfer, right?

Except for certain operations like audio cd ripping

