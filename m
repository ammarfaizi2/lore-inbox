Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267094AbSL3WWn>; Mon, 30 Dec 2002 17:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267096AbSL3WWn>; Mon, 30 Dec 2002 17:22:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24962
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267094AbSL3WWm>; Mon, 30 Dec 2002 17:22:42 -0500
Subject: Re: [PATCH] pnp & pci structure cleanups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20021230221212.GE32324@kroah.com>
References: <Pine.LNX.4.33.0212291228200.532-100000@pnote.perex-int.cz> 
	<20021230221212.GE32324@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 23:12:40 +0000
Message-Id: <1041289960.13684.180.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-30 at 22:12, Greg KH wrote:
> Yeah!  Thanks for taking these fields out of pci.h, I really appreciate
> it.  I'll send this on to Linus in a bit.

Argh I was using those to implement a test "pci_compatible" driver so
that you could feed new pci idents to old drivers. Oh well 

