Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTFAGMx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 02:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTFAGMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 02:12:53 -0400
Received: from [216.148.213.132] ([216.148.213.132]:48880 "EHLO
	smtp.mailix.net") by vger.kernel.org with ESMTP id S261308AbTFAGMx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 02:12:53 -0400
Date: Sun, 1 Jun 2003 08:26:04 +0200
From: Alex Riesen <fork0@users.sf.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk4+: oops by mc -v /proc/bus/pci/00/00.0
Message-ID: <20030601062604.GA4361@steel.home>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <20030531165523.GA18067@steel.home> <20030531195414.10c957b7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030531195414.10c957b7.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton, Sun, Jun 01, 2003 04:54:14 +0200:
> >
> > MC (Midnight Commander 4.6.0 Gentoo) segfaults trying to mmap files
> >  under /proc/bus/pci.
> 
> Thanks.  This will fix it up.
> 

it did, of course.

