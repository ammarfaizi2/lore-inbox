Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUIEPFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUIEPFe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 11:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUIEPFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 11:05:33 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:23851 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266758AbUIEPF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 11:05:29 -0400
Message-ID: <9e47339104090508052850b649@mail.gmail.com>
Date: Sun, 5 Sep 2004 11:05:28 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New proposed DRM interface design
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
In-Reply-To: <1094386050.1081.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040904102914.B13149@infradead.org>
	 <4139A9F4.4040702@tungstengraphics.com>
	 <20040904115442.GD2785@redhat.com>
	 <4139B03A.6040706@tungstengraphics.com>
	 <20040904122057.GC26419@redhat.com>
	 <4139C8A3.6010603@tungstengraphics.com>
	 <9e47339104090408362a356799@mail.gmail.com>
	 <4139FEB4.3080303@tungstengraphics.com>
	 <9e473391040904110354ba2593@mail.gmail.com>
	 <1094386050.1081.33.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Sep 2004 13:07:37 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sad, 2004-09-04 at 19:03, Jon Smirl wrote:
> > This does add some work to the BSD developers but it would make all of
> > the new code that doesn't copy preexisting GPL code fair game. I have
> > no problem marking any new code I write as being BSD licensed, I just
> > don't want to rewrite 80,000 lines of fbdev code.
> 
> If DRI stays the way it is currently licensed no problems arise anyway
> (beyond proprietary people reusing DRI code, which given the license is
> presumably the intent)
> 
If I copy GPL pieces of fbdev in to the DRM drivers it will pollute
the BSD license and turn it into GPL.



-- 
Jon Smirl
jonsmirl@gmail.com
