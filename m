Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267921AbTBKXfk>; Tue, 11 Feb 2003 18:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267539AbTBKXfk>; Tue, 11 Feb 2003 18:35:40 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30080
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267921AbTBKXfj>; Tue, 11 Feb 2003 18:35:39 -0500
Subject: Re: Can't enable dma on /dev/hda
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: maxxle <maxxle@t-online.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1044991886.3923.43.camel@sam>
References: <1044991886.3923.43.camel@sam>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045010715.2326.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Feb 2003 00:45:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 19:31, maxxle wrote:
> Hi!
> 
> I'm running a debian 3.0 System using kernel 2.4.19 (also tried 2.4.20).
> On this system it's not possible to enable dma on /dev/hda (HDD IDE)
> 
> The MoBo is a VIA Board called VIA-C3M266 (CLE266 chipset)
> Northbridge: VT8623
> Southbridge: VT8235

You need 2.4.21pre for the 8235

