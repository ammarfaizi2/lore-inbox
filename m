Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbSL3MVC>; Mon, 30 Dec 2002 07:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbSL3MVC>; Mon, 30 Dec 2002 07:21:02 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45440
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266941AbSL3MVB>; Mon, 30 Dec 2002 07:21:01 -0500
Subject: Re: Highpoint HPT370 not working in 2.4.18+ versions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: system_lists@nullzone.org
Cc: Scott McDermott <vaxerdec@frontiernet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.1.6.2.20021230100446.03168ec8@192.168.2.131>
References: <5.1.1.6.2.20021226012834.037b9558@192.168.2.131>
	<5.1.1.6.2.20021226012834.037b9558@192.168.2.131> 
	<5.1.1.6.2.20021230100446.03168ec8@192.168.2.131>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 13:10:56 +0000
Message-Id: <1041253856.13076.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 09:10, system_lists@nullzone.org wrote:
> 
> Hi there Scott,
> 
>     my card (which not need any patch for working on in 2.4.18 but doesnt 
> work (its simply not detected) on next versions) is:
> 
> HighPoint Technologies, Inc.
> HPT370 UDMA/ATA100 RAID Controller BIOS v1.0.3b1
> 
> have u any idea?

Make sure you have the HPT driver compiled into your kernel

