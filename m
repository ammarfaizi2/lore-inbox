Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUCaPpx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 10:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUCaPpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 10:45:53 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:23424 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262009AbUCaPpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 10:45:52 -0500
Date: Wed, 31 Mar 2004 08:45:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Latest kgdb?
Message-ID: <20040331154541.GH13819@smtp.west.cox.net>
References: <20040319162009.GE4569@smtp.west.cox.net> <200403242011.26314.amitkale@emsyssoft.com> <20040324154355.GD7126@smtp.west.cox.net> <200403251022.39704.amitkale@emsyssoft.com> <20040325151444.GC13366@smtp.west.cox.net> <20040331152925.GA6205@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331152925.GA6205@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 05:29:25PM +0200, Pavel Machek wrote:

> Hi!
> 
> Where can I get latest kgdb? The version on kgdb.sf.net is still
> against 2.6.3, afaics. Or should I forward port it?

CVS is against 2.6.4.  Once 2.6.5 comes out, I'll move it forward again.
Locally, I've got a series of patches vs 2.6.5-rc3 + some -mm bits for
Andrew which I hope to post today, but might not make it until tomorrow.

-- 
Tom Rini
http://gate.crashing.org/~trini/
