Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268445AbTBNNXf>; Fri, 14 Feb 2003 08:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268443AbTBNNXe>; Fri, 14 Feb 2003 08:23:34 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37249
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268442AbTBNNXc>; Fri, 14 Feb 2003 08:23:32 -0500
Subject: Re: 3Com 3cr990 driver release
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Dillow <dillowd@y12.doe.gov>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <3E4C9FAA.FC8A2DC7@y12.doe.gov>
References: <3E4C9FAA.FC8A2DC7@y12.doe.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045233209.7958.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Feb 2003 14:33:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 07:50, David Dillow wrote:
> There are a few issues with the firmware -- DMA to a 2 byte aligned address
> hangs the firmware, so we cannot easily align the IP header, and the firmware
> will always strip the VLAN tags on packet reception, regardless of our
> desires. I hope to work with 3Com to resolve these issues.
> 
> The code is available via BK at
> http://typhoon.bkbits.net/typhoon-2.4
> http://typhoon.bkbits.net/typhoon-2.5

Would you care to make the patches available in a format those of us who
work on open source version control systems can use. Right now Mr McVoy
prohibits me from reviewing your patches.

