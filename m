Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282902AbSAEUvk>; Sat, 5 Jan 2002 15:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283340AbSAEUva>; Sat, 5 Jan 2002 15:51:30 -0500
Received: from zok.SGI.COM ([204.94.215.101]:25482 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S282902AbSAEUvV>;
	Sat, 5 Jan 2002 15:51:21 -0500
Date: Sat, 5 Jan 2002 12:49:53 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-visws-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] Visual Workstation update for 2.4.17
Message-ID: <20020105124953.A757319@sgi.com>
Mail-Followup-To: linux-visws-devel@lists.sf.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've made a new patch for visws support for 2.4.17 availble at sf.net.
It's really just a cleaned up (by no means fully cleaned up, however)
version of the last one.  Don't forget to pass 'mem=xxxM' (where xxx
is the number of megs of RAM on your machine) on the boot line, since
the kernel will only see 128M otherwise.  It's available at the
SourceForge project page (http://sf.net/projects/linux-visws).
Comments and questions welcome.

Thanks,
Jesse
