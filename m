Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbTDEATK (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 19:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbTDEATK (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 19:19:10 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:19687 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S261504AbTDEATJ (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 19:19:09 -0500
Date: Sat, 5 Apr 2003 10:30:20 +1000
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-mm3: hang and crash
Message-ID: <20030405003019.GA491@zip.com.au>
References: <20030404013732.GA466@zip.com.au> <20030403183604.6a4cc385.akpm@digeo.com> <20030404031402.GA457@zip.com.au> <20030403195207.737621f5.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403195207.737621f5.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 07:52:07PM -0800, Andrew Morton wrote:
> CaT <cat@zip.com.au> wrote:
> > Still, the linus.patch produced the same result. If you think it's
> > worthwhile I'll compile out the fa and perc patchesb but I didn't think
> > it significant due to them workign just fine with 2.5.66.
> 
> Well you've already worked out that the problem is due to the i2c and/or
> sensors changes, yes?
> 
> That's the area to start backing stuff out to work out where it broke.

Some more info for you: -bk10 is working fine (except for the pcmcia
thing). Was able to start up my mutts and am currently compiling it with
I2C code to see if it goes then.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
