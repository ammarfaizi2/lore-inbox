Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUJ2T0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUJ2T0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUJ2TZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:25:56 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:53466 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S263500AbUJ2SfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:35:20 -0400
Date: Fri, 29 Oct 2004 11:35:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
       amitkale@linsyssoft.com, mithlesh@linsyssoft.com, ak@suse.de,
       ralf@linux-mips.org, davidm@hpl.hp.com
Subject: Re: [patch 1/8] A different KGDB stub for -mm
Message-ID: <20041029183519.GU2097@smtp.west.cox.net>
References: <1.29102004.trini@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1.29102004.trini@kernel.crashing.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 11:32:20AM -0700, Tom Rini wrote:
 
> Cc: <trini1@cox.net>, <tom.rini@gmail.com>
> The following series of patches adds (or in some cases, replaces) KGDB
> support for i386, ppc32, ia64, x86_64 and mips (both 32 and 64bit
> tested).  This version of KGDB can be used either via serial or ethernet.

... Not off to a good start today, forgot to refresh the descs one last
time before sending.  Only this and I think 2/8 will go out twice, sorry
for the noise.

-- 
Tom Rini
http://gate.crashing.org/~trini/
