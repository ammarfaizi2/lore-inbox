Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129912AbQJZRIp>; Thu, 26 Oct 2000 13:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129918AbQJZRIg>; Thu, 26 Oct 2000 13:08:36 -0400
Received: from [64.64.109.142] ([64.64.109.142]:51729 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129912AbQJZRIZ>; Thu, 26 Oct 2000 13:08:25 -0400
Message-ID: <39F864A7.68326F8B@didntduck.org>
Date: Thu, 26 Oct 2000 13:06:47 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Mircea Damian <dmircea@linux.kappa.ro>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel OOPS on boot
In-Reply-To: <20001026165906.A25943@linux.kappa.ro> <39F83DBD.2869EF54@didntduck.org> <20001026191841.A28277@linux.kappa.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mircea Damian wrote:
> 
> On Thu, Oct 26, 2000 at 10:20:45AM -0400, Brian Gerst wrote:
> > Mircea Damian wrote:
> > >
> > > Hello,
> > >
> > > I'm unable to boot kernel 2.4.0-test10-pre5 on a:
> >
> > Upgrade GCC to 2.91.66 (aka egcs-1.1.2)
> 
> Ok. I can do that, but there is nowhere written that I should do
> that. If I remember right gcc-2.7.2.3 was the preferred compiler for all
> kernels.

The change that broke compiling with 2.7.2.3 was in test10-pre4.  There
is a patch that should be going in to test10-pre6 that documents this
and checks the version.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
