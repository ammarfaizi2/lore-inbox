Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWAFVjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWAFVjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWAFVjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:39:51 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:5048 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751071AbWAFVjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:39:51 -0500
Date: Fri, 6 Jan 2006 16:39:50 -0500
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git2: CONFIGFS_FS shows up as M/y choice, help says "if unsure, say N"
Message-ID: <20060106213950.GA26581@csclub.uwaterloo.ca>
References: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 10:10:13PM +0100, Alessandro Suardi wrote:
> ===========
> Userspace-driven configuration filesystem (EXPERIMENTAL) (CONFIGFS_FS)
> [M/y/?] (NEW)
> 
> Both sysfs and configfs can and should exist together on the
> same system. One is not a replacement for the other.
> 
> If unsure, say N.
> ===========
> 
> I think I'll say M - for now ;)

Sure, if you want to play with configfs you should.  Most users probably
have no interest in helping develop/debug it, so the decomendation makes
perfect sense.

Len Sorensen
