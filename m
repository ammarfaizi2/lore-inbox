Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267340AbTA1O7E>; Tue, 28 Jan 2003 09:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267274AbTA1O6w>; Tue, 28 Jan 2003 09:58:52 -0500
Received: from ns.suse.de ([213.95.15.193]:28681 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267340AbTA1O6Q>;
	Tue, 28 Jan 2003 09:58:16 -0500
Date: Tue, 28 Jan 2003 16:07:35 +0100
From: Stefan Reinauer <stepan@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
Message-ID: <20030128150735.GA31324@suse.de>
References: <398E93A81CC5D311901600A0C9F2928946936D@cubuss2> <20030128121048.GB32488@suse.de> <1043765442.8675.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043765442.8675.2.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Message-Flag: Life is too short to use a crappy OS.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [030128 15:50]:
> On Tue, 2003-01-28 at 12:10, Stefan Reinauer wrote:
> > It's not too much to even state that almost any computer working with
> > Linux 2.4+ can do 800x600 or 1024x768. Anything below that can be
> > considered a special case, regarding the numbers out there. But that
> > does not influence the possibility of using a bootsplash graphics. 
> > On a system you can't use it properly, you probably also would not 
> > want it (i.e. use normal text mode boot instead of a framebuffer
> > driver)
> 
> Lots of systems cannot do 800x600 or 1024x768. Some of them cannot
> do 640x480 very well but 640x480 is safe except for weird kit because
> of the VGA mode support.
 
Safe or not safe depends highly on the kind of hardware we are talking
about. To clarify: 1024x768 is not a problem on most new PCs bought
today. For a PDA or embedded system you maybe only have 320x244. 
My point was rather, if the graphics hardware cannot display a graphical
bootup without drawbacks, it does not hurt to disable it and go back to
text.

  Stefan

-- 
The use of COBOL cripples the mind; its teaching should, therefore, be
regarded as a criminal offense.                      -- E. W. Dijkstra
