Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268024AbUIKCMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268024AbUIKCMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 22:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268056AbUIKCMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 22:12:54 -0400
Received: from zeus.kernel.org ([204.152.189.113]:49346 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268024AbUIKCMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 22:12:52 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Sat, 11 Sep 2004 09:04:42 +0800
User-Agent: KMail/1.5.4
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1094783022.2667.106.camel@gaston> <Pine.GSO.4.58.0409101004320.93@waterleaf.sonytel.be> <200409101635.25738.adaplas@hotpop.com>
In-Reply-To: <200409101635.25738.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409110904.42118.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 September 2004 16:35, Antonino A. Daplas wrote:
>
> > > what about failing register_framebuffer for anything but offb ?
> >
> > Humm, indeed hackerish...
> >
> > But the advantage of this is that we can finally exercise the failure
> > path of many frame buffer device drivers in the wild ;-)
>
> Assuming, as I've mentioned in another thread, that info->fix.name ==
> to video=xxxfb.
>

Sorry Geert, I misinterpret.  And you are correct, but that will be scary :-)

Tony


