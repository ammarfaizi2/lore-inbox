Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313019AbSC0ORp>; Wed, 27 Mar 2002 09:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313020AbSC0OR0>; Wed, 27 Mar 2002 09:17:26 -0500
Received: from rj.sgi.com ([204.94.215.100]:52165 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S313019AbSC0ORF>;
	Wed, 27 Mar 2002 09:17:05 -0500
Subject: Re: Filesystem benchmarks: ext2 vs ext3 vs jfs vs minix
From: Florin Andrei <florin@sgi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203271323330.24894-100000@sphinx.mythic-beasts.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 27 Mar 2002 06:17:04 -0800
Message-Id: <1017238624.30397.18.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-03-27 at 05:54, Matthew Kirkwood wrote:
> 
> 3. The journalled filesystems do have measurable overhead
>    for this workload.

Can you repeat the tests with XFS too?

In my tests, it did the best for database-type workloads (and generally,
for large files with multiple access).

-- 
Florin Andrei

"Sorry judge, we would like to publish the file formats, but the data is
not stored in files. It is stored in a database that is an indivisible
part of the operating system." - a potential future Microsoft excuse

