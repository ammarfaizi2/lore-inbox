Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268064AbUGWVIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268064AbUGWVIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 17:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268065AbUGWVIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 17:08:51 -0400
Received: from herkules.viasys.com ([194.100.28.129]:28883 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S268064AbUGWVIt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 17:08:49 -0400
Date: Sat, 24 Jul 2004 00:08:43 +0300
From: Ville Herva <vherva@viasys.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040723210843.GT19019@viasys.com>
Reply-To: vherva@viasys.com
References: <40FEEEBC.7080104@quark.didntduck.org> <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de> <20040722025539.5d35c4cb.akpm@osdl.org> <20040722193337.GE19329@fs.tum.de> <20040722152839.019a0ca0.pj@sgi.com> <20040722232540.GH19329@fs.tum.de> <1090549329.6113.21.camel@kryten.internal.splhi.com> <20040723063131.GJ16073@viasys.com> <200407232104.i6NL4Zwf003593@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407232104.i6NL4Zwf003593@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 05:04:35PM -0400, you [Valdis.Kletnieks@vt.edu] wrote:
> On Fri, 23 Jul 2004 09:31:31 +0300, Ville Herva said:
> 
> > Anyway, as (one kind of) end user, I do welcome the new development model.
> > I'll get the newest features in manageable manner, and if I don't fancy that
> > I can resort to vendor (Fedora) kernels.
> 
> You *do* realize that the kernel in the Fedora development tree is
> actually *ahead* of the released kernel.org tree, right?
> 
> The current kernel-2.6.7-1.494.src.rpm is based on 2.6.8-rc1-bk5, with a
> bunch of RedHat/Fedora patches on top of that.
> 
> And the 2.6.5-1.358 kernel that shipped in Fedora Core 2 is actually a
> 2.6.6-rc3-bk3 with patches on top of that.
> 
> I think you meant the RHEL series of kernels - current there is
> 2.4.21-15.0.3.EL, with backports of security/bug fixes.

You are absolutely right, Fedora was a bad example. RHEL is better.
