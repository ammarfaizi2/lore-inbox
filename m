Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265800AbSL3UD7>; Mon, 30 Dec 2002 15:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265830AbSL3UD6>; Mon, 30 Dec 2002 15:03:58 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11650
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265800AbSL3UD6>; Mon, 30 Dec 2002 15:03:58 -0500
Subject: Re: Promise 20376 support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: marcel@mesa.nl
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021230204645.B20688@joshua.mesa.nl>
References: <20021230204645.B20688@joshua.mesa.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 20:54:03 +0000
Message-Id: <1041281643.13615.131.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 19:46, Marcel J.E. Mol wrote:
> Hi,
> 
> I've got this Asus A7V8X motherboard that contains a promise 20376
> sata-ide (raid) controller. In the latest kernel sources (2.4 and 2.5) 
> I don't see any mention of this chip yet. Also a google search does
> not reveal much about linux support. 
> Is there already any work in progress for it?

No work, no documentation. If its just a SATA bridge with an existing
ATA controller then you may find you can just add the PCI identifiers
and pretend its a 20276. If it has other new and wonderous features you
may be completely screwed

