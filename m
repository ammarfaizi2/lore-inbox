Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUCCGBB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 01:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUCCGBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 01:01:01 -0500
Received: from [212.28.208.94] ([212.28.208.94]:61444 "HELO dewire.com")
	by vger.kernel.org with SMTP id S261693AbUCCGBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 01:01:00 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: David Weinehall <david@southpole.se>
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
Date: Wed, 3 Mar 2004 07:00:56 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Ho <andrewho@animezone.org>, Dax Kelson <dax@gurulabs.com>,
       Peter Nelson <pnelson@andrew.cmu.edu>, Hans Reiser <reiser@namesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
References: <4044119D.6050502@andrew.cmu.edu> <40453538.8050103@animezone.org> <20040303014115.GP19111@khan.acc.umu.se>
In-Reply-To: <20040303014115.GP19111@khan.acc.umu.se>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403030700.57164.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 March 2004 02:41, David Weinehall wrote:
> On Tue, Mar 02, 2004 at 08:30:32PM -0500, Andrew Ho wrote:
> > XFS is the best filesystem.
> 
> Well it'd better be, it's 10 times the size of ext3, 5 times the size of
> ReiserFS and 3.5 times the size of JFS.
> 
> And people say size doesn't matter.

Recoverability matters to me. The driver could be 10 megabyte and
*I* would not care. XFS seems to stand no matter how rudely the OS
is knocked down.

After a few hundred crashes (laptop, kids, drained batteries) I'd expect 
something bad to happen, but no. XFS returns my data quickly and happily
everytime (as opposed to most of the time). Maybe the're a bit of luck.

Salute to XFS!

-- robin
