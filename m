Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751883AbWFVTQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbWFVTQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbWFVTQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:16:43 -0400
Received: from xenotime.net ([66.160.160.81]:45228 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751883AbWFVTQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:16:42 -0400
Date: Thu, 22 Jun 2006 12:19:27 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Al Boldi <a1426z@gawab.com>
Cc: adaplas@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_VGACON_SOFT_SCROLLBACK crashes 2.6.17
Message-Id: <20060622121927.e7d27e9c.rdunlap@xenotime.net>
In-Reply-To: <200606222036.45081.a1426z@gawab.com>
References: <200606211715.58773.a1426z@gawab.com>
	<200606220005.32446.a1426z@gawab.com>
	<4499E89F.6030509@gmail.com>
	<200606222036.45081.a1426z@gawab.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 20:36:45 +0300 Al Boldi wrote:

> Antonino A. Daplas wrote:
> > Al Boldi wrote:
> > > Antonino A. Daplas wrote:
> > >> Al Boldi wrote:
> > >>> Enabling CONFIG_VGACON_SOFT_SCROLLBACK causes random fatal system
> > >>> freezes.
> > >>>
> > >>> Especially, ping 10.1 -A easily causes a complete system hang during
> > >>> scroll.
> > >>>
> > >>> Is there an easy way to fix this, other than disabling the option?
> > >>
> > >> I can't duplicate your problem. Did it ever work before?
> > >
> > > This option did not exist before 2.6.17.
> >
> > I meant if you tried any of the -rc kernels.
> 
> If -rc's were additive, I would probably use them.  But they are not :(

How big is that problem?  You can use ketchup
(http://www.selenic.com/ketchup/wiki/) or
http://www.xenotime.net/linux/scripts/grab-kernel-rc
to automate that.

---
~Randy
