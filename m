Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUCCLSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 06:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbUCCLSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 06:18:00 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:45988 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262441AbUCCLR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 06:17:56 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Code freeze on lite patches and schedule for submission into mainline kernel
Date: Wed, 3 Mar 2004 16:47:47 +0530
User-Agent: KMail/1.5
Cc: Tom Rini <trini@kernel.crashing.org>, George Anzinger <george@mvista.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
References: <200403031354.10370.amitkale@emsyssoft.com> <20040303105653.GB342@elf.ucw.cz>
In-Reply-To: <20040303105653.GB342@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403031647.47450.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 Mar 2004 4:26 pm, Pavel Machek wrote:
> Hi!
>
> > We have two sets of kgdb patches as of now: [core-lite, i386-lite, 8250]
> > and [core, i386, ppc, x86_64, eth]. First set of kgdb patches (lite) is
> > fairly clean. Let's consider it to be a candicate for submission to
> > mainline kernel.
> >
> > I am freezing the lite patches wrt. feature updates. Only bug-fixes and
> > code cleanups will be allowed in lite patches. You can make any feature
> > enhancements to second set of patches.
>
> Sounds good.
>
> > I propose following schedule for pushing kgdb lite into mainline kernel:
> > Take 1: 8th , Take 2: 15th, Take 3: 22nd, Take 4:29th. I'll download the
> > kernel snapshot (http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/)
> > on these dates and submit a single patch for possible acceptance into
> > mainline kenrel and feedback from community. Hopefully we'll succeed by
> > end of this month.
>
> Well, you should have really cc-ed this one to andrew :-). [What?
> Schedule for pushing? No patchbombing? ;-))))))))))]

I spared him of stress :-)

-Amit

