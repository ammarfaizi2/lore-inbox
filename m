Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUGXQZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUGXQZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 12:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUGXQZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 12:25:26 -0400
Received: from 30.Red-80-36-33.pooles.rima-tde.net ([80.36.33.30]:60882 "EHLO
	linalco.com") by vger.kernel.org with ESMTP id S261405AbUGXQZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 12:25:24 -0400
Date: Sat, 24 Jul 2004 18:21:11 +0200
From: Ragnar Hojland Espinosa <ragnar.hojland@linalco.com>
To: szonyi calin <caszonyi@yahoo.com>
Cc: Paul Jackson <pj@sgi.com>, Adrian Bunk <bunk@fs.tum.de>, akpm@osdl.org,
       corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040724162111.GA22206@linalco.com>
References: <20040722152839.019a0ca0.pj@sgi.com> <20040723081637.93875.qmail@web52903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040723081637.93875.qmail@web52903.mail.yahoo.com>
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 10:16:37AM +0200, szonyi calin wrote:
> Are you sure ? There are a number of distribution who use the
>  stable kernel from kernel.org and some of them are much faster
> (if you remember, compiling a kernel to suit your needs
>  sometimes improve performance). 
> One size _does not_ fit all.

Right.  Aaaand if I remember correctly you may download the source
for, say, a RHEL kernel for gratis from Redhat (or a whitebox distro)
and make menuconfig it and compile it the same way you do vanilla
kernels.

In fact, a single tree is far better for stable development in general.
Vanilla things that break get spotted sooner, we avoid 2.x.0 the
syndrome, and distro kernels in general may get more eyes from clueful
people that otherwise would ignore them and leave the problems to
less resourceful users.

"Dont Panic" :)
-- 
Ragnar Hojland - Project Manager
Linalco "Specialists in Linux and Free Software"
http://www.linalco.com  Tel: +34-91-4561700
