Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312277AbSDXOsy>; Wed, 24 Apr 2002 10:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSDXOsx>; Wed, 24 Apr 2002 10:48:53 -0400
Received: from c17736.belrs2.nsw.optusnet.com.au ([211.28.31.90]:25760 "EHLO
	bozar") by vger.kernel.org with ESMTP id <S312277AbSDXOsw>;
	Wed, 24 Apr 2002 10:48:52 -0400
Date: Thu, 25 Apr 2002 00:48:21 +1000
From: Andre Pang <ozone@algorithm.com.au>
To: linux-kernel@vger.kernel.org
Subject: Implementation of FreeBSD's KSEs on Linux?
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Message-Id: <1019659701.449462.23147.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Are there any current projects to implement kernel-scheduled
entities (KSEs) on Linux?  They currently exist on FreeBSD, and
seem like a really neat idea.  I

The KSE research paper can be found at:

    http://people.freebsd.org/~jasone/kse/

I think that KSEs are very similar to Scheduler Activations,
although they added support for threads which can be scheduled in
kernel-space as well as user-space.


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
