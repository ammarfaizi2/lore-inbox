Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVKQMrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVKQMrm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 07:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVKQMrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 07:47:42 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:32868 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750777AbVKQMrl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 07:47:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rqQEI1hFEewoyGgEOPMIq3wikkYxyAi2sX8+rgAKTwbph1erzUTluLWpXpzHX/EcT7+AeChkmyq4t8gMfyHPF6Z7f7Ly3Wn8ND2ejRyi6iA41gSZk/IwZ/lg94eRJmuaYm3bN1+7v0YEVYISxZHWOiEZWkyWNa5/W6UuOzGeptM=
Message-ID: <81b0412b0511170447j36efc887idf3a942443197c56@mail.gmail.com>
Date: Thu, 17 Nov 2005 13:47:40 +0100
From: Alex Riesen <raa.lkml@gmail.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC] HOWTO do Linux kernel development - take 3
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20051117070956.GA20899@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117070956.GA20899@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/05, Greg KH <gregkh@suse.de> wrote:
> 2.6.x kernel tree
> -----------------
> 2.6.x kernels are maintained by Linus Torvalds, and can be found on
> kernel.org in the pub/linux/kernel/v2.6/ directory.  Its development
> process is as follows:
>   - As soon as a new kernel is released a two weeks window is open,
>     during this period of time maintainers can submit big diffs to
>     Linus, usually the patches that have already been included in the
>     -mm kernel for a few weeks.  The preferred way to submit big changes
>     is using git (the kernel's source management tool, more information
>     can be found at http://git.or.cz/) but plain patches are also just
>     fine.

The http://git.or.cz/ is broken. Maybe
http://www.kernel.org/pub/software/scm/git/docs/ (manual) or
http://gitscm.org/ ?
