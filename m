Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270593AbTGNO1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270584AbTGNO1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:27:50 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:26345
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S270697AbTGNORV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:17:21 -0400
Date: Mon, 14 Jul 2003 10:32:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Anders Gustafsson - xbox patch monkey <andersg@0x63.nu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] XBox Gaming System subarchitecture.
Message-ID: <20030714143209.GA5118@gtf.org>
References: <20030714124933.GB20708@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714124933.GB20708@h55p111.delphi.afb.lu.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 02:49:33PM +0200, Anders Gustafsson - xbox patch monkey wrote:
> A wise man recently said:
> 
> ''That pretty much cuts the list of "needs to be supported" down to x86,
>   ia64, x86-64 and possibly sparc/alpha.''
> 
> Some parts of x86 are still not supported, namely the bastardized PC called
> Xbox. The patch below fixes that. Rediffed to latest bk.


Personally I think we should wait on merging this until the furor over
the current Xbox hacks dies down.  It can be yet another architecture
that catches up after 2.6.0 is released, which isn't a big deal IMO.

	Jeff



