Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267835AbTBROhh>; Tue, 18 Feb 2003 09:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267837AbTBROhh>; Tue, 18 Feb 2003 09:37:37 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:650
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267835AbTBROhg>; Tue, 18 Feb 2003 09:37:36 -0500
Subject: Re: no promise PDC2070/PDC20267 with 2.5.62 (works ok with 2.4.20)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: kernel@ddx.a2000.nu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0302181334240.5743@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302181334240.5743@ddx.a2000.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045583358.24171.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 18 Feb 2003 15:49:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 13:07, kernel@ddx.a2000.nu wrote:
> intel se7500cw2 dual xeon mainbord (with dual 2GHz) with onboard ide and
> onboard fasttrak100 (PDC20267) and pci tx4 (PDC2070) (and 3ware
> 7850/adaptec 2940uw)
> 
> kernel 2.5.62 boot dmesg output :

2.5.62 IDE doesn't yet support a lot of stuff 2.4 does. I'm working on
that currently. It needs both IDE and PCI layer changes to resolve


