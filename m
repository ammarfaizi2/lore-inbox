Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbTAATvz>; Wed, 1 Jan 2003 14:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTAATvz>; Wed, 1 Jan 2003 14:51:55 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56454
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261723AbTAATvy>; Wed, 1 Jan 2003 14:51:54 -0500
Subject: Re: 2.4.21-pre2 harddisk not in /proc/partitions with pdc_new
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1041416324.982.11.camel@sun>
References: <1041416324.982.11.camel@sun>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Jan 2003 20:42:56 +0000
Message-Id: <1041453776.21708.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-01 at 10:18, Soeren Sonnenburg wrote:
> As this box has two pdc20268 (promise tx2) ide controllers I can
> reproduce this behaviour on both of them with different harddisks.
> 
> Linux was booting using a harddisk on the onboard via vt8235 chipset
> (asus a7v8x).
> 
> This problem does not occur with 2.4.20. 
> 
> I will happily supply additional information if needed.

Please provide a full lspci and also the dmesg of the boot. I know what
this might be, the boot logs should confirm my suspicion one way or
another

