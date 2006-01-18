Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWAREzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWAREzJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 23:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWAREzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 23:55:09 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:28138 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030181AbWAREzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 23:55:08 -0500
Subject: Re: userspace filesystem Vs kernelspace filesystem
From: Lee Revell <rlrevell@joe-job.com>
To: jeff shia <tshxiayu@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7cd5d4b40601172045j531a21b3y41db1dfbf84b769f@mail.gmail.com>
References: <7cd5d4b40601172045j531a21b3y41db1dfbf84b769f@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 23:55:05 -0500
Message-Id: <1137560106.3587.57.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 12:45 +0800, jeff shia wrote:
> Hello,everyone!
> 
> Linux kernel provides vfs for the various physical filesystems.The
> profit we get from the
> VFS is just the standard interface it provides such as read and write?
> 
> Can we implement a user space filesystem which is actually a library?I
> think it will be
> faster than kernel space filesystem through the vfs layer.
> 
> Any suggestions or commnets?

Search list archives for FUSE (Filesystem in USErspace).

Lee

