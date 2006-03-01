Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWCAXUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWCAXUy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWCAXUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:20:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60339 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751094AbWCAXUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:20:53 -0500
Date: Wed, 1 Mar 2006 15:20:39 -0800
From: Paul Jackson <pj@sgi.com>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       yanmin.zhang@intel.com
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060301152039.ab2c453d.pj@sgi.com>
In-Reply-To: <20060301225013.GA20834@kroah.com>
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
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh, and Paul, this all works just fine with no -mm, right?

Do you mean - does 2.6.16-rc5 work for me?

I haven't tried that yet. The lowest I went in Andrew's 2.6.16-rc5-rc1
patch stack was one patch, which would be 2.6.16-rc5 plus
"linus.patch." That worked for me, as did a few points between that and
gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch

I will try a plain 2.6.16-rc5 as well, shortly.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
