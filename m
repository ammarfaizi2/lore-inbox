Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVKQM7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVKQM7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 07:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVKQM7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 07:59:24 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:56840 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750784AbVKQM7Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 07:59:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UOlms3gF/z73HJiyPHqSjF/qHqigS+GD+nrA0d3Ef53LWarwt2A/CbMh7AI+p9l+W65kh20dZlWYpfnpJnGM1Ghhtcf3YhPlJcU2m7VSy46t8Qvg2D/PoBInuzH3Tx4djm43MhwhecJR0C3ZBiPimMmWSyovBg3XzG12mqC/A/g=
Message-ID: <625fc13d0511170459u73b9501gee6a154073059aa@mail.gmail.com>
Date: Thu, 17 Nov 2005 06:59:23 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] HOWTO do Linux kernel development - take 3
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <81b0412b0511170447j36efc887idf3a942443197c56@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117070956.GA20899@kroah.com>
	 <81b0412b0511170447j36efc887idf3a942443197c56@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/05, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 11/17/05, Greg KH <gregkh@suse.de> wrote:
> > 2.6.x kernel tree
> > -----------------
> > 2.6.x kernels are maintained by Linus Torvalds, and can be found on
> > kernel.org in the pub/linux/kernel/v2.6/ directory.  Its development
> > process is as follows:
> >   - As soon as a new kernel is released a two weeks window is open,
> >     during this period of time maintainers can submit big diffs to
> >     Linus, usually the patches that have already been included in the
> >     -mm kernel for a few weeks.  The preferred way to submit big changes
> >     is using git (the kernel's source management tool, more information
> >     can be found at http://git.or.cz/) but plain patches are also just
> >     fine.
>
> The http://git.or.cz/ is broken. Maybe
> http://www.kernel.org/pub/software/scm/git/docs/ (manual) or
> http://gitscm.org/ ?

Broken how?  It works for me...

josh
