Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUHSJfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUHSJfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUHSJfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:35:41 -0400
Received: from aun.it.uu.se ([130.238.12.36]:44763 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264444AbUHSJf1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:35:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16676.29765.963260.634569@alkaid.it.uu.se>
Date: Thu, 19 Aug 2004 11:35:01 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: =?ISO-8859-1?Q?Ram=F3n_Rey_Vicente?= <ramon.rey@hispalinux.es>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Update ftape webpage
In-Reply-To: <4123F54E.4090900@hispalinux.es>
References: <4123F54E.4090900@hispalinux.es>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ramón Rey Vicente writes:
 > --- linux-2.6-rrey/MAINTAINERS.orig	2004-08-19 01:57:52.405537120 +0200
 > +++ linux-2.6-rrey/MAINTAINERS	2004-08-19 02:26:44.012733140 +0200
 > @@ -849,7 +849,7 @@
 >  P:	Claus-Justus Heine
 >  M:	claus@momo.math.rwth-aachen.de
 >  L:	linux-tape@vger.kernel.org
 > -W:	http://www-math.math.rwth-aachen.de/~LBFM/claus/ftape/
 > +W:	http://www.instmath.rwth-aachen.de/~heine/ftape/
 >  S:	Maintained

NAK. If anything it should be marked orphaned or something.
Heine hasn't maintained the in-kernel code for ages, and the
web page you listed gives 403 errors on download attempts.

Don't remove it though. It still mostly works.
