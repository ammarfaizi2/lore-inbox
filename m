Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUCDOh5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 09:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbUCDOh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 09:37:56 -0500
Received: from guanin.uni-konstanz.de ([134.34.240.60]:952 "EHLO
	guanin.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S261889AbUCDOhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 09:37:50 -0500
Message-ID: <1078411067.40473f3b6b835@webmail.uni-konstanz.de>
Date: Thu,  4 Mar 2004 15:37:47 +0100
From: Pascal Gienger <pascal.gienger@uni-konstanz.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       David Weinehall <david@southpole.se>,
       Andrew Ho <andrewho@animezone.org>, Dax Kelson <dax@gurulabs.com>,
       Peter Nelson <pnelson@andrew.cmu.edu>, Hans Reiser <reiser@namesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@oss.software.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
Subject: Re: [Jfs-discussion] Re: Desktop Filesystem Benchmarks in 2.6.3
References: <4044119D.6050502@andrew.cmu.edu>  <40453538.8050103@animezone.org> <20040303014115.GP19111@khan.acc.umu.se>  <200403030700.57164.robin.rosenberg.lists@dewire.com> <1078307033.904.1.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1078307033.904.1.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 193.96.192.155
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>:

> But XFS easily breaks down due to media defects. Once ago I used
> XFS,
> but I lost all data on one of my volumes due to a bad block on my
> hard
> disk. XFS was unable to recover from the error, and the XFS recovery
> tools were unable to deal with the error.

1. How long ago is "Once ago"? Did you report that to the xfs
developers?
2. Speaking for servers, we live in a RAID and/or SAN-world. The media
error issue is a non-issue.

Just my $0.02,

Pascal
