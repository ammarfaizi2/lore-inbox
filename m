Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275341AbTHGNrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275347AbTHGNrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:47:13 -0400
Received: from [195.141.226.27] ([195.141.226.27]:9482 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S275341AbTHGNrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:47:09 -0400
Subject: Re: [Dri-devel] Re: any DRM update scheduled for 2.4.23-pre?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mitch@0Bits.COM
In-Reply-To: <1060255207.3123.13.camel@dhcp22.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0308061357480.4381-100000@logos.cnet>
	 <1060255207.3123.13.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Organization: Debian, XFree86
Message-Id: <1060264025.875.48.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 07 Aug 2003 15:47:05 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-07 at 13:20, Alan Cox wrote:
> On Mer, 2003-08-06 at 17:58, Marcelo Tosatti wrote:
> > > It's a complete DRM-4.3 tree. He has to decide between an update of existing 
> > > 4.2 code or an addition of a new subdirectory drm-4.3 + proper config.in 
> > > entry.
> > 
> > Does DRM 4.3 work with both XFree 4.2 and 4.3 ? 
> > 
> > I dont so, right?
> 
> It doesn't. As discussed on the kernel list and DRI list a while ago.
> The -ac tree / Red Hat one does because it has some additional magic to
> spot i810 problems.

That's a bug which can be fixed then, doesn't warrant separate copies in
the kernel. I'm sure Dave would happily integrate the fix in DRI CVS.


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

