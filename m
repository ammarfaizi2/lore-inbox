Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbTK3GE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 01:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264856AbTK3GE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 01:04:58 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:54239 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264855AbTK3GE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 01:04:57 -0500
Date: Sat, 29 Nov 2003 23:05:04 -0700
From: Chris Ernst <hhchris@comcast.net>
To: m__morrell@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM
Message-Id: <20031129230504.5e8ece40.hhchris@comcast.net>
In-Reply-To: <200311292307.32492.m__morrell@yahoo.com>
References: <200311292307.32492.m__morrell@yahoo.com>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set the protocol to IMPS/2 in XF86Conig:

Option      "Protocol" "IMPS/2"

	- Chris

On Sat, 29 Nov 2003 23:07:32 -0500
Mike Morrell <m__morrell@yahoo.com> wrote:

> Scroll wheel on Mouseman+ mouse does not work with 2.6.0-test11. Works fine on 
> 2.4.22 kernel.
> 
> Mouse movement works, only scroll wheel is affected. Tried an Intellimouse and 
> wheel works fine on both 2.4.22 and 2.6.0-test11. I did not see a kernel 
> config option that would affect this.
> 
> Linux morrell1 2.6.0-test11 #1 SMP Sat Nov 29 22:40:11 EST 2003 i686 Intel(R) 
> Pentium(R) 4 CPU 2.40GHz GenuineIntel GNU/Linux
> 
> Gnu C                  3.3.2
> Gnu make               3.80
> util-linux             2.12
> mount                  2.12
> module-init-tools      0.9.15-pre3
> e2fsprogs              1.34
> xfsprogs               2.6.0
> nfs-utils              1.0.6
> Linux C Library        2.3.2
> Dynamic linker (ldd)   2.3.2
> Procps                 3.1.14
> Net-tools              1.60
> Kbd                    1.08
> Sh-utils               5.0.91
> Modules Loaded
> 
> Gentoo distro
> 
> 
