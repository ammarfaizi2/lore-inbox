Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbUCCJ7b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 04:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUCCJ7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 04:59:31 -0500
Received: from [212.28.208.94] ([212.28.208.94]:16904 "HELO dewire.com")
	by vger.kernel.org with SMTP id S262366AbUCCJ73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 04:59:29 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
Date: Wed, 3 Mar 2004 10:59:26 +0100
User-Agent: KMail/1.6.1
Cc: David Weinehall <david@southpole.se>, Andrew Ho <andrewho@animezone.org>,
       Dax Kelson <dax@gurulabs.com>, Peter Nelson <pnelson@andrew.cmu.edu>,
       Hans Reiser <reiser@namesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
References: <4044119D.6050502@andrew.cmu.edu> <200403030700.57164.robin.rosenberg.lists@dewire.com> <1078307033.904.1.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1078307033.904.1.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403031059.26483.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 March 2004 10:43, Felipe Alfaro Solana wrote:
> But XFS easily breaks down due to media defects. Once ago I used XFS,
> but I lost all data on one of my volumes due to a bad block on my hard
> disk. XFS was unable to recover from the error, and the XFS recovery
> tools were unable to deal with the error.

What file systems work on defect media? 

As for crashed disks I rarely bothered trying to "fix" them anymore. I save
what I can and restore what's backed up and recovery tools (other than
the undo-delete ones) usually destroy what's left, but that's not unique to
XFS. Depending on how good my backups are I sometimes try the recovery
tools just to see, but that has never helped so far.

-- robin
