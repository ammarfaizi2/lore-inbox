Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUE1LQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUE1LQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 07:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUE1LQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 07:16:27 -0400
Received: from lakermmtao05.cox.net ([68.230.240.34]:20206 "EHLO
	lakermmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261244AbUE1LQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:16:19 -0400
Date: Fri, 28 May 2004 02:21:41 -0400
From: Chris Shoemaker <c.shoemaker@cox.net>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: ftp.kernel.org
Message-ID: <20040528062141.GA18118@cox.net>
References: <Pine.GSO.4.33.0405280018250.14297-100000@sweetums.bluetronic.net> <200405280941.38784.m.watts@eris.qinetiq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405280941.38784.m.watts@eris.qinetiq.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 09:41:38AM +0100, Mark Watts wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> > On Thu, 27 May 2004, Martin J. Bligh wrote:
> > >They switched to vsftpd very recently ... presumably then.
> >
> > That would explain it.  The default is to turn it off.
> >
> > >Why would you mirror via ftp, instead of rsync anyway?
> >
> > I have more control with mirror.  And I've been using mirror for
> > *ahem* a decade.  I've been using rsync for mirroring debian, but
> > it's slow and often fails to complete.  Mirror has never let me
> > down ('tho it has deleted entire archives before *grin*)
> 
> Agreed - fmirror is so much more reliable than rsync (imho) that it makes 
> rsync into a worst-case option for retrieving files.
> 

  bug reports to rsync@lists.samba.org are appreciated...

-chris

> - -- 
> Mark Watts
> Senior Systems Engineer
> QinetiQ Trusted Information Management
> Trusted Solutions and Services group
> GPG Public Key ID: 455420ED
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> 
> iD8DBQFAtvtCBn4EFUVUIO0RAl6dAJ9C+1Xu6nIMTFI3ggchYyEAXTu7fACgm9Vt
> 1VZ6sy9Ra/iK6MvCkxRUxVk=
> =3PkP
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
