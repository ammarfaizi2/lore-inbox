Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVJJTqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVJJTqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 15:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVJJTqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 15:46:31 -0400
Received: from pat.uio.no ([129.240.130.16]:60876 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751184AbVJJTqa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 15:46:30 -0400
Subject: Re: NFSACL protocol extension for NFSv3
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Martin <martin.povolny@solnet.cz>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <200510101532.03219.agruen@suse.de>
References: <43428305.9060106@solnet.cz>
	 <1128452188.8713.20.camel@lade.trondhjem.org>
	 <200510101532.03219.agruen@suse.de>
Content-Type: text/plain; charset=utf-8
Date: Mon, 10 Oct 2005 15:46:11 -0400
Message-Id: <1128973571.8451.50.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-4, required 12,
	autolearn=disabled, AWL 1.00, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 10.10.2005 Klokka 15:32 (+0200) skreiv Andreas Gruenbacher:
> Trond,
> 
> Andrew still has nfsacl-solaris-vxfs-compatibility-fix.patch in 
> 2.6.14-rc2-mm2. This makes sense for 2.6.14 as well IMO -- what do you think?

Looks ok to me. ACK...

Cheers,
  Trond

> On Tuesday 04 October 2005 20:56, Trond Myklebust wrote:
> > ty den 04.10.2005 Klokka 15:26 (+0200) skreiv Martin:
> > > Hallo,
> > >
> > > sorry for bothering, just a question: is there a chance for NFSACL
> > > from -mm tree to be merged into main tree soon?
> > >
> > > I am especially interested in the nfsacl-umask.diff part (ignoring
> > > umask in directories with default ACL).
> >
> > Soon, as in "just in time to make it into kernel 2.6.13"?
> >
> > Cheers,
> >   Trond
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> Cheers,
> Andreas.

