Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUHYJpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUHYJpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 05:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHYJpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 05:45:23 -0400
Received: from aun.it.uu.se ([130.238.12.36]:16525 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264639AbUHYJpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 05:45:18 -0400
Date: Wed, 25 Aug 2004 11:44:49 +0200 (MEST)
Message-Id: <200408250944.i7P9inIo024208@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] Update ftape webpage
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ramon.rey@hispalinux.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 16:39:22 -0300, Marcelo Tosatti wrote:
> >  > -W:	http://www-math.math.rwth-aachen.de/~LBFM/claus/ftape/
> >  > +W:	http://www.instmath.rwth-aachen.de/~heine/ftape/
> >  >  S:	Maintained
> > 
> > NAK. If anything it should be marked orphaned or something.
> > Heine hasn't maintained the in-kernel code for ages, and the
> > web page you listed gives 403 errors on download attempts.
> > 
> > Don't remove it though. It still mostly works.
> 
> Mikael,
> 
> the URL works just fine. I've applied this to v2.4 mainline.

The top-level pages work, but the ones for accessing
actual files don't work due to 403 errors. For instance,

http://zeus.instmath.rwth-aachen.de/~heine/ftape/archives/

accessible from Archive -> click on location for HTTP,
doesn't work. Clicking on the FTP location gets a 530
(Login Incorrect) error. Several files are announced as
links into the archives directory, and are not accessible,
like the ChangeLog and FAQ (in the Development page).

However, the old web address is even more broken, so I
guess it's better to list the new one.
