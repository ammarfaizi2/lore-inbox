Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWCBAKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWCBAKR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 19:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWCBAKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 19:10:17 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50617 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750780AbWCBAKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 19:10:15 -0500
Date: Wed, 1 Mar 2006 16:10:06 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       yanmin.zhang@intel.com
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060301161006.f487e982.pj@sgi.com>
In-Reply-To: <20060301154053.73d9d348.akpm@osdl.org>
References: <20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
	<20060301002631.48e3800e.akpm@osdl.org>
	<20060301015338.b296b7ad.pj@sgi.com>
	<20060301192103.GA14320@kroah.com>
	<20060301125802.cce9ef51.pj@sgi.com>
	<20060301213048.GA17251@kroah.com>
	<20060301142631.22738f2d.akpm@osdl.org>
	<20060301225013.GA20834@kroah.com>
	<20060301152039.ab2c453d.pj@sgi.com>
	<20060301154053.73d9d348.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> If 2.6.16-rc5+linus.patch works and
> 2.6.16-rc5+linus.patch+gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch
> crashes then we have a pretty good idea of where to look.

Now I'm trying:
  http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm2-pre1.gz
since that's the one left on my list of things to try that you
haven't suspected would be little help to try.

I'll skip the plain 2.6.16-rc5 unless someone asks for it again.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
