Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWCAKPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWCAKPJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWCAKPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:15:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:35767 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932172AbWCAKPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:15:07 -0500
Date: Wed, 1 Mar 2006 02:14:32 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org, greg@kroah.com,
       neilb@cse.unsw.edu.au
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060301021432.442072e1.pj@sgi.com>
In-Reply-To: <20060301020255.39fcc6a8.akpm@osdl.org>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
	<20060301002631.48e3800e.akpm@osdl.org>
	<20060301015338.b296b7ad.pj@sgi.com>
	<20060301020255.39fcc6a8.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, thanks.  So
> gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch is the
> problem.   Odd.

See my "drat" correction that crossed paths with your message.

I'm testing gregkh-driver-put_device-might_sleep.patch now.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
