Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVHKGTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVHKGTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 02:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVHKGTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 02:19:09 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:45473 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S932280AbVHKGTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 02:19:08 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Lee Revell <rlrevell@joe-job.com>
Date: Thu, 11 Aug 2005 08:17:55 +0200
MIME-Version: 1.0
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
Cc: lkml <linux-kernel@vger.kernel.org>
Message-ID: <42FB09B4.20901.48E239C@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <1123727560.30850.1.camel@mindpipe>
References: <1123726394.32531.33.camel@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.95.0+V=3.95+U=2.07.102+R=04 July 2005+T=107508@20050811.060458Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Aug 2005 at 22:32, Lee Revell wrote:

> On Wed, 2005-08-10 at 19:13 -0700, john stultz wrote:
> > All,
> > 	Here's the next rev in my rework of the current timekeeping subsystem.
> > No major changes, only some cleanups and further splitting the larger
> > patches into smaller ones.
> 
> Last I heard this made gettimeofday() 20% slower on x86.  Is this still
> the case?

If it's only 20% for an increase in resolution of 100000%, it's quite good ;-)

Regards,
Ulrich


> 
> Lee
> 


