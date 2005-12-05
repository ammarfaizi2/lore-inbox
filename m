Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVLEBWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVLEBWE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 20:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVLEBWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 20:22:03 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:30080 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S1750702AbVLEBWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 20:22:03 -0500
Message-Id: <200512050103.jB513vPR017425@pincoya.inf.utfsm.cl>
To: Greg KH <greg@kroah.com>
cc: "M." <vo.sinh@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
In-Reply-To: Message from Greg KH <greg@kroah.com> 
   of "Sun, 04 Dec 2005 14:47:07 -0800." <20051204224707.GB8914@kroah.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 04 Dec 2005 22:03:57 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
> On Sun, Dec 04, 2005 at 04:24:36PM +0100, M. wrote:

[...]

> > yeah but I would mean if there's a 6months release cycle like GNOME & co.
> > there would be more opportunities in different distros using the same
> > kernel like those distros do with GNOME & co. If they use the same
> > 'current' 6months kernel available in the 18/24 time window this will
> > lead to unified base kernel for every distro and those distro could
> > mantain it for years

> The kernel is unlike GNOME in so many different ways, there's just no
> way to compare their development cycles.

Gnome is a /collection/ of (mostly independent) programs, after a while
what program+version survives a stress test is decreed to be part of
version N + 1 to be released at the 6-month point; lather, rinse,
repeat. In that sense it is much more like a distribution (which also have
similar release cycles). The kernel is /one/ program, and large and complex
to boot.

> People remember, the kernel evolves organically.  We don't know what's
> going to be in the next 2 kernel releases just because we don't know
> what's going to show up, and what hardware is going to be released, and
> what kind of problems people are going to have, and what kind of
> proposed patches are going to work out.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
