Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbTDCQKF>; Thu, 3 Apr 2003 11:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261314AbTDCQKF>; Thu, 3 Apr 2003 11:10:05 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.27]:28056 "EHLO
	mwinf0402.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261313AbTDCQKD>; Thu, 3 Apr 2003 11:10:03 -0500
Date: Thu, 3 Apr 2003 18:21:23 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Message-ID: <20030403162123.GA17123@iliana>
References: <4E5C514B42@vcnet.vc.cvut.cz> <20030403141530.GA8858@iliana> <1049383273.11742.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049383273.11742.0.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 04:21:14PM +0100, Alan Cox wrote:
> On Iau, 2003-04-03 at 15:15, Sven Luther wrote:
> > > Read is not enough. If you have connected one /dev/fbx to two monitors,
> > > you must find highest common denominator for them, and use this one.
> > 
> > Err, i don't understand this ? Do you mean you are outputing to two
> > monitors at the same time ?
> 
> I think you mean lowest common denominator.
> 
> > If that is so maybe you mean, speaking in graphic card terminology, and
> > not in fbdev one, that you are sharing one common framebuffer between
> > two outputs, right, possibly doing mirroring tricks or something such ?
> 
> Classic example is a SiS 6326 driving monitor and TV. You need to keep
> the display to TV acceptable ranges.

You mean, driving both display with the same ramdac ?

Friendly,

Sven Luther
