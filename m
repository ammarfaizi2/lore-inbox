Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315239AbSD2Xxq>; Mon, 29 Apr 2002 19:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315241AbSD2Xxp>; Mon, 29 Apr 2002 19:53:45 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:51213 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315239AbSD2Xxo>; Mon, 29 Apr 2002 19:53:44 -0400
Date: Tue, 30 Apr 2002 01:53:31 +0200
From: tomas szepe <kala@pinerecords.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: The tainted message
Message-ID: <20020429235330.GA27307@louise.pinerecords.com>
In-Reply-To: <20020429192107.GA26369@louise.pinerecords.com> <26170.1020121574@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 7 days, 16:48)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Nobody can agree on the warning text.  Anything less than the full
>   kernel FAQ entry is incomplete.

Hey, no need for sarcasm here; I don't think the four lines could offend
anyone, being merely a different solution proposal. Yours is pretty good
too.

> Solution:
> 
>   modutils 2.4.16 says
> 
>   Warning: loading <module> will taint the kernel.  Reason <reason>
>     See <TAINT_URL> for information on tainted modules
>   Module loaded, with warnings
> 
>   Printing 'Module loaded, with warnings' makes it clear that the
>   module has been loaded.  TAINT_URL defaults to lkml FAQ.  Vendors can
>   ship modutils with a TAINT_URL that points to their support policy.

Neat!


T.
