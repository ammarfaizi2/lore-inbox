Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVD2Lma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVD2Lma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 07:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVD2Lm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 07:42:29 -0400
Received: from smtp.server-home.net ([195.137.212.50]:29970 "EHLO
	smtp.server-home.net") by vger.kernel.org with ESMTP
	id S262485AbVD2Lm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 07:42:27 -0400
Date: Fri, 29 Apr 2005 13:42:47 +0200
From: Walter Hofmann <lkml-050429134106-0d5b@secretlab.mine.nu>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: ext3 issue..
Message-ID: <20050429114246.GZ14675@secretlab.mine.nu>
References: <E1DRTmM-0003Cv-00@gimli.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DRTmM-0003Cv-00@gimli.local>
X-GPG-Fingerprint: 91D7 2B68 786F 7A3D 18FF E168 EAF4 8754
X-GPG-Key: http://search.keyserver.net:11371/pks/lookup?search=0xDE547385&op=index
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 29 Apr 2005 11:42:28.0251 (UTC) FILETIME=[8531B6B0:01C54CB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Apr 28, 2005 at 09:59:39AM -0500, Davy Durham wrote:
> > Crazy huh?  Well, I unmounted /home and did an fsck -f  on the partition 
> > and remounted it.  Then everything looked okay.
> 
> No, I haven't heard of any such problems with ext2/3 filesystems.
> This is the first time that someone was reported a specific problem
> with the # of blocks used accounting.  

I reported one some time ago:
 http://marc.theaimsgroup.com/?l=linux-kernel&m=108549779731780
There was just a single response in this thread from someone else seeing 
the same problem.

Walter
