Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267643AbUBTAzC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUBTAyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:54:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:27529 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267643AbUBTAwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:52:42 -0500
Date: Thu, 19 Feb 2004 16:52:41 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Jamie Lokier <jamie@shareable.org>, thockin@sun.com,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: sysconf - exposing constants to userspace
Message-ID: <20040219165241.F22989@build.pdx.osdl.net>
References: <20040219204820.GC9155@sun.com> <200402191630.47047.jeffpc@optonline.net> <20040220002034.GC5590@mail.shareable.org> <200402191929.54604.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200402191929.54604.jeffpc@optonline.net>; from jeffpc@optonline.net on Thu, Feb 19, 2004 at 07:29:45PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Sipek (jeffpc@optonline.net) wrote:
> If I understand the original post correctly, the numbers that we don't make 
> available to userspace are compile time constants. For example, since I can't 
> think of anything better, NR_CPUS. It is set during the config process, but 
> one cannot read the number from userspace while running that kernel. I know 
> that there are better examples, but I just can't think of any at the moment.

like /proc/sys/kernel/version? ;-)

later,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
