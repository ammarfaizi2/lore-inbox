Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbUCIPho (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUCIPho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:37:44 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:49656 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S262019AbUCIPhl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:37:41 -0500
Date: Tue, 9 Mar 2004 08:37:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: George Anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Message-ID: <20040309153740.GI15065@smtp.west.cox.net>
References: <200403081504.30840.amitkale@emsyssoft.com> <200403081714.05521.amitkale@emsyssoft.com> <404CF165.1010402@mvista.com> <200403091038.55749.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403091038.55749.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 10:38:55AM +0530, Amit S. Kale wrote:
> On Tuesday 09 Mar 2004 3:49 am, George Anzinger wrote:
[snip]
> > You really do need a gdb that handles the dwarft2 frames.  This is a rather
> > new gdb (I use the CVS version).
> 
> Let's just stick to gdb 6.0 and binutils 2.14. CVS versions of gdb and 
> binutils are too risky for someone who is trying to learn linux kernel by 
> using kgdb.

I think that depends on the level of crap we have to do compared to how
it would be done with a newer version of gdb or binutils.  GDB 6.1 for
example should be out soon.

-- 
Tom Rini
http://gate.crashing.org/~trini/
