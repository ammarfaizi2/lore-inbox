Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbTGKSV0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTGKSVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:21:07 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:12552
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264909AbTGKSAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:00:10 -0400
Date: Fri, 11 Jul 2003 11:14:53 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711181453.GA976@matchmail.com>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030711140219.GB16433@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711140219.GB16433@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 03:02:19PM +0100, Dave Jones wrote:
> Enormous block size support.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

How about "block device size" instead?  This made me think of blocks larger
than page size initially (even though I know that hasn't happened).

>   o  ide_scsi is completely broken in 2.5.x. Known problem. If you need it
>      either use 2.4 or fix it 8)

Is this still true?  I seem to recall testing a kernel in the 2.5.6x range,
and it worked.  (haven't tested more recent kernels yet -- compiling one now
though)

> EXT3.
> ~~~~~
> - data=journal mode is currently broken.

Is this still true (or is that still in -mm?)

