Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267530AbTAQPXB>; Fri, 17 Jan 2003 10:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTAQPXB>; Fri, 17 Jan 2003 10:23:01 -0500
Received: from msg.vodafone.pt ([212.18.167.162]:57983 "EHLO msg.vodafone.pt")
	by vger.kernel.org with ESMTP id <S267530AbTAQPXA>;
	Fri, 17 Jan 2003 10:23:00 -0500
Subject: Re: radeonfb almost there.. but not quite! :)
From: "Paulo Andre'" <fscked@netvisao.pt>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200301162108.WAA22987@post.webmailer.de>
References: <20030115182012$25b7@gated-at.bofh.it>
	 <20030116134006$783d@gated-at.bofh.it>
	 <200301162108.WAA22987@post.webmailer.de>
Content-Type: text/plain
Organization: Corleone Hacking Corp.
Message-Id: <1042817507.251.4.camel@nostromo.orion.int>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 17 Jan 2003 15:31:47 +0000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2003 15:31:04.0901 (UTC) FILETIME=[72DAA750:01C2BE3D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-16 at 21:07, Arnd Bergmann wrote:

> I also have a small problem when switching to and from X. Most of 
> the time everything is fine, but sometimes it is unreadable and
> I have to switch back and forth again.
> 
> This is on an IBM Thinkpad A30p with 1600x1200 local display.
> radeonfb_pci_register BEGIN
> radeonfb: ref_clk=2700, ref_div=60, xclk=16600 from BIOS
> radeonfb: probed DDR SGRAM 32768k videoram
> radeon_get_moninfo: bios 4 scratch = 1000004
> radeonfb: panel ID string: 1600x1200
> radeonfb: detected DFP panel size from BIOS: 1600x1200
> radeonfb: ATI Radeon M6 LY DDR SGRAM 32 MB
> radeonfb: DVI port LCD monitor connected
> radeonfb: CRT port no monitor connected
> radeonfb_pci_register END

Do you have CONFIG_DRM=y ?

I'd _really_ like to have some feedback from James Simmons on this.

	../Paulo

