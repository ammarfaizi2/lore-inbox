Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbUBVPWg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 10:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbUBVPWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 10:22:36 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:2946 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261515AbUBVPWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 10:22:34 -0500
Date: Sun, 22 Feb 2004 16:22:33 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Cross Compiling [update]
Message-ID: <20040222152232.GB23051@MAIL.13thfloor.at>
Mail-Followup-To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	linux-kernel@vger.kernel.org
References: <20040222035350.GB31813@MAIL.13thfloor.at> <20040222124541.GA1064@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222124541.GA1064@gallifrey>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 12:45:41PM +0000, Dr. David Alan Gilbert wrote:
> * Herbert Poetzl (herbert@13thfloor.at) wrote:
> > 
> > Hi Folks!
> > 
> > Here is an update to the Kernel Cross Compiling thread 
> > I started ten days ago ...
> 
> Hi,
>    Quite a while ago I tried going through a similar
> process.   I found at the time the debian toolchain-source
> package helped in this process.
> 
> There is however one thing you seem to have missed - you
> tend to need subtely different versions of gcc and binutils
> for each combination.

not missed, but ignored on purpose ;)

> It certainly used to be the case that every architectures
> kernel used to have different known issues in both gcc
> and binutils; and there was a fair amount of 'oh don't
> use that version, it produces broken kernels' with
> different answers for each architecture.

hmm, that sounds too familiar, and I already prepared
to have different binutils, different gcc and some special
conditions for each build ... but I'm trying to minimize
the differences where possible ...

> At one time I tried to make a summary page showing where
> the kernel source and tools are for each architecture;
> but I never kept it upto date.
> (http://www.treblig.org/Linux_kernel_source_finder.html)

this looks quite useful, maybe you have some 'updated'
info, which could be of value to this efford, if so,
please let me know ...

anyway, thanks for the url, I was planning to do something
similar when I have all the details ...

best,
Herbert

> Dave
> 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
> \ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
