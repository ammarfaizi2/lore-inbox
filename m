Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbUCCK0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUCCK0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:26:08 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:58598 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S262423AbUCCK0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:26:05 -0500
From: "Mike Gigante" <mg@sgi.com>
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
       "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: "David Weinehall" <david@southpole.se>,
       "Andrew Ho" <andrewho@animezone.org>, "Dax Kelson" <dax@gurulabs.com>,
       "Peter Nelson" <pnelson@andrew.cmu.edu>,
       "Hans Reiser" <reiser@namesys.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <ext3-users@redhat.com>,
       <jfs-discussion@www-124.southbury.usf.ibm.com>,
       <reiserfs-list@namesys.com>, <linux-xfs@oss.sgi.com>
Subject: RE: Desktop Filesystem Benchmarks in 2.6.3
Date: Wed, 3 Mar 2004 21:24:10 +1100
Message-ID: <KHEHKKKAAILFJGJCHDCAAEFFEKAA.mg@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200403031059.26483.robin.rosenberg.lists@dewire.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday 03 March 2004 10:43, Felipe Alfaro Solana wrote:
> But XFS easily breaks down due to media defects. Once ago I used XFS,
> but I lost all data on one of my volumes due to a bad block on my hard
> disk. XFS was unable to recover from the error, and the XFS recovery
> tools were unable to deal with the error.

A single bad-block rendered the entire filesystem non-recoverable 
for XFS? Sounds difficult to believe since there is redundancy such
as multiple copies of the superblock etc.

I can believe you lost *some* data, but "lost all my data"??? -- I 
believe that you'd have to had had *considerably* more than 
"a bad block" :-)

Mike

