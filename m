Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbUCCHsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 02:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbUCCHsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 02:48:11 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:55305 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262408AbUCCHsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 02:48:10 -0500
Date: Wed, 3 Mar 2004 07:47:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: David Weinehall <david@southpole.se>, Dax Kelson <dax@gurulabs.com>,
       Peter Nelson <pnelson@andrew.cmu.edu>, Hans Reiser <reiser@namesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
Subject: Re: Desktop Filesystem Benchmarks in 2.6.3
Message-ID: <20040303074756.A25861@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, David Weinehall <david@southpole.se>,
	Dax Kelson <dax@gurulabs.com>,
	Peter Nelson <pnelson@andrew.cmu.edu>,
	Hans Reiser <reiser@namesys.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
	jfs-discussion@www-124.southbury.usf.ibm.com,
	reiserfs-list@namesys.com, linux-xfs@oss.sgi.com
References: <4044119D.6050502@andrew.cmu.edu> <4044366B.3000405@namesys.com> <4044B787.7080301@andrew.cmu.edu> <1078266793.8582.24.camel@mentor.gurulabs.com> <20040302224758.GK19111@khan.acc.umu.se> <40453538.8050103@animezone.org> <20040303014115.GP19111@khan.acc.umu.se> <20040303014115.GP19111@khan.acc.umu.se.suse.lists.linux.kernel> <p73ptbu4psx.fsf@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p73ptbu4psx.fsf@brahms.suse.de>; from ak@suse.de on Wed, Mar 03, 2004 at 03:39:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 03:39:26AM +0100, Andi Kleen wrote:
> A lot of this is actually optional features the other FS don't have,
> like support for separate realtime volumes and compat code for old 
> revisions, journaled quotas etc. I think you could
> relatively easily do a "mini xfs" that would be a lot smaller. 

And a whole lot of code to stay somewhat in sync with other codebases..

