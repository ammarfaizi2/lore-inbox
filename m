Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUBTAo1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267616AbUBTAoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:44:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:48877 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267658AbUBTAfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:35:22 -0500
Date: Thu, 19 Feb 2004 16:35:19 -0800
From: Chris Wright <chrisw@osdl.org>
To: Tim Hockin <thockin@sun.com>
Cc: Jamie Lokier <jamie@shareable.org>, Jeff Sipek <jeffpc@optonline.net>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: sysconf - exposing constants to userspace
Message-ID: <20040219163519.E22989@build.pdx.osdl.net>
References: <20040219204820.GC9155@sun.com> <200402191630.47047.jeffpc@optonline.net> <20040220002034.GC5590@mail.shareable.org> <20040220002140.GG9155@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040220002140.GG9155@sun.com>; from thockin@sun.com on Thu, Feb 19, 2004 at 04:21:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tim Hockin (thockin@sun.com) wrote:
> sysctls are all writable (unless I am missing something).  A lot of these
> things are not really tunables.

no, they actually have a mode.  some are 0444.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
