Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbTFTAjd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 20:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTFTAjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 20:39:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54030 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262090AbTFTAjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 20:39:32 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: SCM domains [was Re: Linux 2.5.71]
Date: 19 Jun 2003 17:53:05 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bctlth$lvd$1@cesium.transmeta.com>
References: <20030618043527.GA21723@work.bitmover.com> <Pine.LNX.3.96.1030619163732.12043A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.96.1030619163732.12043A-100000@gatekeeper.tmr.com>
By author:    Bill Davidsen <davidsen@tmr.com>
In newsgroup: linux.dev.kernel
>
> On Tue, 17 Jun 2003, Larry McVoy wrote:
> 
> > On Tue, Jun 17, 2003 at 09:11:07PM -0700, H. Peter Anvin wrote:
> > > Followup to:  <20030618011455.GF542@hopper.phunnypharm.org>
> > > By author:    Ben Collins <bcollins@debian.org>
> > > In newsgroup: linux.dev.kernel
> > > > > 
> > > > > I have no problem setting up CNAMEs in kernel.org if people are OK with
> > > > > it.  Setting up actual servers is another matter.
> > > > 
> > > > CNAMES on kernel.org would be perfect.
> > > > 
> > > 
> > > So right now cvs, svn and bk all -> kernel.bkbits.net?
> > 
> > We only need cvs and svn; bk is hosted at linux.bkbits.net.
> 
> It still makes sense to have a CNAME for bk.kernel.org to match the
> others. Much easier to remember and guess; if you know one you can intuit
> the others.
> 

I just added bk.kernel.org -> linux.bkbits.net.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
