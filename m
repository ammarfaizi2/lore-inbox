Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751906AbWISLTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbWISLTW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 07:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbWISLTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 07:19:22 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:34945 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751899AbWISLTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 07:19:21 -0400
Date: Tue, 19 Sep 2006 13:19:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: mingo@elte.hu, paulus@samba.org
Subject: [patch 0/3] Directed yield take 3.
Message-ID: <20060919111917.GB21713@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 10:53 -0700, Andrew Morton wrote:
> > nobody has complained about my spinlock yield patches.
> 
> Complain.
> 
> I had to hunt around a bit to discover that this functionality has
> something to do with "giving up the timeslice of a virtual cpu in favour of
> a specific cpu".  And also that it is expected to be of some
> briefly-alluded-to benefit on powerpc.
> 
> So...  Could you please flesh out the description/rationale rather a lot
> and cc linux-kernel on the patches?

Ok here we go, 
added some more beef to the description of patch #1 and replaced the
description of patch #2. Good enough now?
 
-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
