Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbTAIRvF>; Thu, 9 Jan 2003 12:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbTAIRvF>; Thu, 9 Jan 2003 12:51:05 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6798
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266938AbTAIRu4>; Thu, 9 Jan 2003 12:50:56 -0500
Subject: Re: MB without keyboard controller / USB-only keyboard ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030109183952.6be142fe.skraw@ithnet.com>
References: <20030109114247.211f7072.skraw@ithnet.com>
	 <1042134121.27796.20.camel@irongate.swansea.linux.org.uk>
	 <20030109183952.6be142fe.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042137928.27796.48.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Jan 2003 18:45:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 17:39, Stephan von Krawczynski wrote:
> > > pc_keyb: controller jammed (0xFF)
> > 
> > Does your BIOS do keyboard emulation ?
> 
> It is Compaq EVO D510. It has merely nothing of interest in the BIOS (no
> keyboard emu). As far as I remember it contains an I845 chipset.

Can you use the USB keyboard to configure the BIOS during boot. If so
then it almost certainly has USB bios emulation. Another trivial test
that would be useful is to stick a freedos boot floppy in the box and
see if freedos works

