Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130074AbQKMFmf>; Mon, 13 Nov 2000 00:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130149AbQKMFmZ>; Mon, 13 Nov 2000 00:42:25 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:30216 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130074AbQKMFmH>; Mon, 13 Nov 2000 00:42:07 -0500
Date: Sun, 12 Nov 2000 23:38:19 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: /net/ip_vs.h in stock kernels
Message-ID: <20001112233819.C15243@vger.timpanogas.org>
In-Reply-To: <3A0C91C7.D5530CFF@timpanogas.org> <Pine.SOL.4.21.0011112251070.15229-100000@ultra1.inconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.SOL.4.21.0011112251070.15229-100000@ultra1.inconnect.com>; from dax@gurulabs.com on Sat, Nov 11, 2000 at 10:52:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 10:52:38PM -0700, Dax Kelson wrote:
> Jeff V. Merkey said once upon a time (Fri, 10 Nov 2000):
> 
> > 
> > I noticed that the ip_vs.h include is not in the main kernel tree or ip
> > virtual switch support while I was attempting to buid the pirahnna web
> > server.  Is this module a patch located somewhere else on
> > ftp.kernel.org.
> 
> Jeff,
> 	Red Hat started included the IPVS patches from
> http://www.linuxvirtualserver.org/ starting with RH6.1 (I believe).  You
> can find the patch they use in the kernel src.rpm, or go get the patch
> from the URL listed above.

Dax,

Thanks.  I noticed the pirahna web server rpm would rebuild unless the 
kernel had this patch.  I was wondering why it wasn't in the stock kernels
since it's GPL.  We may want to consider including it.

Jeff

> 
> Dax
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
