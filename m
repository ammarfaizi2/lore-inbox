Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267826AbUJPAk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267826AbUJPAk5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 20:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUJPAk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 20:40:57 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:3719 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267826AbUJPAkx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 20:40:53 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       "Kendall Bennett" <KendallB@scitechsoft.com>,
       Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Sat, 16 Oct 2004 08:41:08 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       penguinppc-team@lists.penguinppc.org,
       linuxconsole-dev@lists.sourceforge.net
References: <416FB624.31033.1D23BE5@localhost> <416FE8D9.18954.2984F7A@localhost>
In-Reply-To: <416FE8D9.18954.2984F7A@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410160841.08441.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 October 2004 06:12, Kendall Bennett wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> > On Fri, Oct 15, 2004 at 11:36:04AM -0700, Kendall Bennett wrote:
> > > Helge Hafting <helgehaf@aitel.hist.no> wrote:
> > That's fine.  What I meant, was please make it independent of the
> > VESA framebuffer driver, because one might want to use an
> > acellerated driver when one is available.
>
> Oh, it already is. The VESA driver is not actually done yet so the only
> drivers using VideoBoot right now are the accelerated ones ;-)
>

If these get in (emulator with/without the video boot), I'm willing to
modify the vesafb driver.

Tony


