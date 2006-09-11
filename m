Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWIKFOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWIKFOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWIKFOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:14:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932149AbWIKFOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:14:41 -0400
Date: Sun, 10 Sep 2006 22:14:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc6-mm1
Message-Id: <20060910221421.1aeac3c9.akpm@osdl.org>
In-Reply-To: <200609102237_MC3-1-CAD6-7C3@compuserve.com>
References: <200609102237_MC3-1-CAD6-7C3@compuserve.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Sep 2006 22:34:33 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> On Fri, 8 Sep 2006 01:13:17 -0700, Andrew Morton wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/
> 
> $ cd 2.6.18-rc6-mm1
> $ tar xjf 2.6.18-rc6-mm1-broken-out.tar.bz2
> $ mv broken-out patches
> $ quilt push -a
> ...
> Applying patch gregkh-driver-pm-pci-and-ide-handle-pm_event_prethaw.patch
> patching file drivers/ide/ide.c
> Hunk #2 FAILED at 1221.
> 1 out of 2 hunks FAILED -- rejects in file drivers/ide/ide.c
> patching file drivers/pci/pci.c
> Patch gregkh-driver-pm-pci-and-ide-handle-pm_event_prethaw.patch does not apply (enforce with -f)

It works for me - I expect your tree is out of sync.
