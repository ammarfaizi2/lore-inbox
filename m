Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275331AbTHGOIQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275350AbTHGOIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:08:15 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:28803 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S275331AbTHGOHz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:07:55 -0400
Subject: Re: [Dri-devel] Re: any DRM update scheduled for 2.4.23-pre?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mitch@0Bits.COM
In-Reply-To: <1060264025.875.48.camel@thor.holligenstrasse29.lan>
References: <Pine.LNX.4.44.0308061357480.4381-100000@logos.cnet>
	 <1060255207.3123.13.camel@dhcp22.swansea.linux.org.uk>
	 <1060264025.875.48.camel@thor.holligenstrasse29.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1060265022.3168.55.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 15:03:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 14:47, Michel Dänzer wrote:
> > It doesn't. As discussed on the kernel list and DRI list a while ago.
> > The -ac tree / Red Hat one does because it has some additional magic to
> > spot i810 problems.
> 
> That's a bug which can be fixed then, doesn't warrant separate copies in
> the kernel. I'm sure Dave would happily integrate the fix in DRI CVS.

I'd have to take a look what DRI CVS does and doesn't currently contain. That's
something I can't realistically expect time for until October

