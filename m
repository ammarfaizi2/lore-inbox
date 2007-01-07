Return-Path: <linux-kernel-owner+w=401wt.eu-S932359AbXAGCt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbXAGCt4 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbXAGCtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:49:55 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:37474 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359AbXAGCtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:49:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iaskNPmx3+aM7J7+KXwSuoBEkYBdd/IyGIj+WMT5iH/nU9Ba1thcTjp/+5YBoDAvT92srqzTIQOuprCdzht1DhFSYxaU7ymjHjrTa3j1134K8pU3Rfb1k2SdOWdzwA6PKQl/O6DMkoo/mjXj+4o+IxeDrBWEJqX4H3LTl05Fo9E=
Message-ID: <9a8748490701061849m2c8d42fbn457f105b2e905bff@mail.gmail.com>
Date: Sun, 7 Jan 2007 03:49:54 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH 2.6.20-rc3] DAC960: kmalloc->kzalloc/Casting cleanups
Cc: "Randy Dunlap" <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20070107020010.GH19020@Ahmed>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070106131725.GB19020@Ahmed>
	 <20070106094630.51aa62e8.randy.dunlap@oracle.com>
	 <20070107020010.GH19020@Ahmed>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/07, Ahmed S. Darwish <darwish.07@gmail.com> wrote:
> On Sat, Jan 06, 2007 at 09:46:30AM -0800, Randy Dunlap wrote:
>
> > On Sat, 6 Jan 2007 15:17:25 +0200 Ahmed S. Darwish wrote:
> >
> > > Hi all,
> > > I'm not able to find the DAC960 block driver maintainer. If someones knows
> > > please reply :).
> >
> > It's orphaned.  Andrew can decide to merge this, or one of the
> > storage or block maintainers could possibly do that.
> > or it could go thru KJ, but then Andrew may still end up
> > merging it.
>
> Should Kernel janitors then care of cleaning orphaned files ?.
> If so, I should forward it to Andrew Morton without CCing LKML again, right ?
>

Sending the patch to LKML and Cc'ing Andrew and KJ would be my approach.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
