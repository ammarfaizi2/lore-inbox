Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266322AbTABSqV>; Thu, 2 Jan 2003 13:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266323AbTABSqV>; Thu, 2 Jan 2003 13:46:21 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23176
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266322AbTABSqV>; Thu, 2 Jan 2003 13:46:21 -0500
Subject: Re: UDMA 133 on a 40 pin cable
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030102182932.GA27340@linux.kappa.ro>
References: <20030102182932.GA27340@linux.kappa.ro>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Jan 2003 19:37:49 +0000
Message-Id: <1041536269.24901.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-02 at 18:29, Teodor Iacob wrote:
> Hello,
> 
> Today i mounted a HDD on my secondary IDE on a 40 pin cable and surprise
> the kernel set it up on UDMA 133:
> 
> hdd: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=119150/16/63, UDMA(133)

What controller and disks ?

> I wouldn't have notice this unless I got some errors:

It got CRC errors, not suprisingly and will drop back. Nevertheless it
shouldnt have gotten this wrong, so more info would be good.

