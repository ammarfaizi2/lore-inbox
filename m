Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbTDLEhK (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 00:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbTDLEhK (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 00:37:10 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:51354 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S263132AbTDLEhJ (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 00:37:09 -0400
Date: Sat, 12 Apr 2003 14:48:40 +1000
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, adilger@clusterfs.com
Subject: Re: 2.5.66: slow to friggin slow journal recover
Message-ID: <20030412044840.GA455@zip.com.au>
References: <20030401100237.GA459@zip.com.au> <20030401022844.2dee1fe8.akpm@digeo.com> <20030412021638.GA650@zip.com.au> <20030411192413.279f0574.akpm@digeo.com> <20030412023848.GB650@zip.com.au> <20030411195308.11812ee9.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411195308.11812ee9.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 07:53:08PM -0700, Andrew Morton wrote:
> CaT <cat@zip.com.au> wrote:
> > > How many files are on the filesystem?
> > 
> > 197MB: 2728 files
> > 1.2GB: 53707 files
> > 
> > > How much physical memory does the machine have?
> > 
> > 256MB
> 
> scrub that theory then.

Do you still want the alt-sysrq-m stuff? And is there anything else I
can do? profiling? apply a patch with debugging stuff that'd give you a
clue? etc...

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
