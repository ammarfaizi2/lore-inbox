Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUIEPSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUIEPSw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 11:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUIEPSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 11:18:52 -0400
Received: from the-village.bc.nu ([81.2.110.252]:13980 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266805AbUIEPSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 11:18:36 -0400
Subject: Re: New proposed DRM interface design
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
In-Reply-To: <9e47339104090508052850b649@mail.gmail.com>
References: <20040904102914.B13149@infradead.org>
	 <4139A9F4.4040702@tungstengraphics.com> <20040904115442.GD2785@redhat.com>
	 <4139B03A.6040706@tungstengraphics.com> <20040904122057.GC26419@redhat.com>
	 <4139C8A3.6010603@tungstengraphics.com>
	 <9e47339104090408362a356799@mail.gmail.com>
	 <4139FEB4.3080303@tungstengraphics.com>
	 <9e473391040904110354ba2593@mail.gmail.com>
	 <1094386050.1081.33.camel@localhost.localdomain>
	 <9e47339104090508052850b649@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094393713.1264.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 05 Sep 2004 15:15:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-05 at 16:05, Jon Smirl wrote:
> > If DRI stays the way it is currently licensed no problems arise anyway
> > (beyond proprietary people reusing DRI code, which given the license is
> > presumably the intent)
> > 
> If I copy GPL pieces of fbdev in to the DRM drivers it will pollute
> the BSD license and turn it into GPL.

There is no reason to do that. The fb layer of Linux and BSD is very
different and both provide fb drawing functionality.

