Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268328AbUHXVPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268328AbUHXVPg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268331AbUHXVPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:15:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43692 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268328AbUHXVP2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:15:28 -0400
Date: Tue, 24 Aug 2004 16:39:22 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: =?iso-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Update ftape webpage
Message-ID: <20040824193922.GA9565@logos.cnet>
References: <4123F54E.4090900@hispalinux.es> <16676.29765.963260.634569@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <16676.29765.963260.634569@alkaid.it.uu.se>
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 11:35:01AM +0200, Mikael Pettersson wrote:
> Ramón Rey Vicente writes:
>  > --- linux-2.6-rrey/MAINTAINERS.orig	2004-08-19 01:57:52.405537120 +0200
>  > +++ linux-2.6-rrey/MAINTAINERS	2004-08-19 02:26:44.012733140 +0200
>  > @@ -849,7 +849,7 @@
>  >  P:	Claus-Justus Heine
>  >  M:	claus@momo.math.rwth-aachen.de
>  >  L:	linux-tape@vger.kernel.org
>  > -W:	http://www-math.math.rwth-aachen.de/~LBFM/claus/ftape/
>  > +W:	http://www.instmath.rwth-aachen.de/~heine/ftape/
>  >  S:	Maintained
> 
> NAK. If anything it should be marked orphaned or something.
> Heine hasn't maintained the in-kernel code for ages, and the
> web page you listed gives 403 errors on download attempts.
> 
> Don't remove it though. It still mostly works.

Mikael,

the URL works just fine. I've applied this to v2.4 mainline.
