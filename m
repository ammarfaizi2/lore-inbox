Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVJJNcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVJJNcL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 09:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVJJNcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 09:32:11 -0400
Received: from mx1.suse.de ([195.135.220.2]:55944 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750782AbVJJNcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 09:32:11 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE LINUX Products GMBH
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: NFSACL protocol extension for NFSv3
Date: Mon, 10 Oct 2005 15:32:02 +0200
User-Agent: KMail/1.8
Cc: Martin <martin.povolny@solnet.cz>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <43428305.9060106@solnet.cz> <1128452188.8713.20.camel@lade.trondhjem.org>
In-Reply-To: <1128452188.8713.20.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510101532.03219.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond,

Andrew still has nfsacl-solaris-vxfs-compatibility-fix.patch in 
2.6.14-rc2-mm2. This makes sense for 2.6.14 as well IMO -- what do you think?

On Tuesday 04 October 2005 20:56, Trond Myklebust wrote:
> ty den 04.10.2005 Klokka 15:26 (+0200) skreiv Martin:
> > Hallo,
> >
> > sorry for bothering, just a question: is there a chance for NFSACL
> > from -mm tree to be merged into main tree soon?
> >
> > I am especially interested in the nfsacl-umask.diff part (ignoring
> > umask in directories with default ACL).
>
> Soon, as in "just in time to make it into kernel 2.6.13"?
>
> Cheers,
>   Trond
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Cheers,
Andreas.
