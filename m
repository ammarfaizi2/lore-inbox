Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUBKOgD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUBKOgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:36:03 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:35011 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261779AbUBKOf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:35:59 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: BitKeeper repo for KGDB
Date: Wed, 11 Feb 2004 20:05:13 +0530
User-Agent: KMail/1.5
Cc: Matt Mackall <mpm@selenic.com>, Pavel Machek <pavel@suse.cz>,
       akpm@osdl.org, george@mvista.com, Andi Kleen <ak@suse.de>,
       jim.houston@comcast.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040127184029.GI32525@stop.crashing.org> <200402101357.39236.amitkale@emsyssoft.com> <20040210192649.GM5219@smtp.west.cox.net>
In-Reply-To: <20040210192649.GM5219@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402112005.13624.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OOPS!
I started downloading your changes from bitkeeper web interface and didn't 
finish that. We have got again out of sync.

I have setup a cvs repository in the meantime. More info at 
http://kgdb.sourceforge.net/cvs.html

You can add yourself to kgdb project as a developer. Then you'll be able to 
checkin changes yourself.

Thanks.
-Amit

On Wednesday 11 Feb 2004 12:56 am, Tom Rini wrote:
> On Tue, Feb 10, 2004 at 01:57:39PM +0530, Amit S. Kale wrote:
> > Tom,
> > Can you please post diffs wrt. 2.6.x kernels for the bitkeeper challanged
> > (me :)?
>
> I appologize for not getting to this sooner, but I've been doing a lot
> of cleanups and such to the code (and not being as well versed in the
> gdb protocol as I'd have like to been, spending some time looking into
> user-error type bugs).  But I'm now at the point where I'm much happier
> with how KGDB works wrt breaking in, resuming sessions, etc, so I'm
> going to start double checking kgdboe again and hopefully checkin, and
> then break out for Andrew all of the stuff I've got.  The following is
> a patch against what I've pushed last (debug bits and all):

