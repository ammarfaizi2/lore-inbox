Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWCBQwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWCBQwa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWCBQwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:52:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64950 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751349AbWCBQwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:52:30 -0500
Date: Thu, 2 Mar 2006 08:52:17 -0800
From: Paul Jackson <pj@sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: hch@infradead.org, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Proc: move proc fs hooks from cpuset.c to
 proc/fs/base.c
Message-Id: <20060302085217.8ec38ebe.pj@sgi.com>
In-Reply-To: <m1y7zskdsi.fsf@ebiederm.dsl.xmission.com>
References: <20060302070812.15674.50176.sendpatchset@jackhammer.engr.sgi.com>
	<20060302084739.GC21902@infradead.org>
	<20060302062359.5940ff7f.pj@sgi.com>
	<m1y7zskdsi.fsf@ebiederm.dsl.xmission.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Agreed.  However the direction I am gradually moving fs/proc/base.c
> is the opposite.

Oh - ok fine.

I had seen something from Andrew a couple of days ago
that led me to a different understanding in this particular
case.

Andrew - kill this patch (unless you know better.)

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
