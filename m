Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUIJIeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUIJIeN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUIJIeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:34:13 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:40125 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267259AbUIJIeI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:34:08 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 7/7] fbdev: Add Tile Blitting support
Date: Fri, 10 Sep 2004 16:35:23 +0800
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
References: <200409100534.56680.adaplas@hotpop.com> <Pine.GSO.4.58.0409100957130.93@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0409100957130.93@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409101635.23527.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 September 2004 15:58, Geert Uytterhoeven wrote:

> > move a +	 rectangular section of a screen, the rectangle willbe described
> > in
>
>                                                         ^^^^^^
> 							will be
>
> > +	 terms of number of tiles in the x- and y-axis.
> > +
> > +	 This is particularly important to one driver, the matroxfb.  If
>
>                                                        ^^^^^^^^^^^^
> 						       matroxfb?
>

Which proves that documentation is the last thing I check :-)

Thanks.

Tony


