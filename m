Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275226AbTHGLYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 07:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275240AbTHGLYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 07:24:16 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:35714 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S275226AbTHGLYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 07:24:14 -0400
Subject: Re: [Dri-devel] Re: any DRM update scheduled for 2.4.23-pre?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Mikael Pettersson <mikpe@csd.uu.se>, faith@valinux.com,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mitch@0Bits.COM
In-Reply-To: <Pine.LNX.4.44.0308061357480.4381-100000@logos.cnet>
References: <Pine.LNX.4.44.0308061357480.4381-100000@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060255207.3123.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 12:20:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-06 at 17:58, Marcelo Tosatti wrote:
> > It's a complete DRM-4.3 tree. He has to decide between an update of existing 
> > 4.2 code or an addition of a new subdirectory drm-4.3 + proper config.in 
> > entry.
> 
> Does DRM 4.3 work with both XFree 4.2 and 4.3 ? 
> 
> I dont so, right?

It doesn't. As discussed on the kernel list and DRI list a while ago.
The -ac tree / Red Hat one does because it has some additional magic to
spot i810 problems.


