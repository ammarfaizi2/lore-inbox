Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVIOUgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVIOUgP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVIOUgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:36:15 -0400
Received: from beer.tclug.org ([71.36.145.29]:22160 "EHLO beer.tclug.org")
	by vger.kernel.org with ESMTP id S1751218AbVIOUgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:36:14 -0400
Date: Thu, 15 Sep 2005 15:36:03 -0500 (CDT)
From: Jima <jima@beer.tclug.org>
To: "David S. Miller" <davem@davemloft.net>
cc: kloczek@rudy.mif.pg.gda.pl, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, aurora-sparc-devel@lists.auroralinux.org,
       davem@redhat.com
Subject: Re: [2.6.14-rc1/sparc54]: BUG: soft lockup detected on CPU#0!
In-Reply-To: <20050915.133026.21581824.davem@davemloft.net>
Message-ID: <Pine.LNX.4.63.0509151533530.26824@beer.tclug.org>
References: <Pine.BSO.4.62.0509151929580.5000@rudy.mif.pg.gda.pl>
 <20050915.133026.21581824.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jima@beer.tclug.org
X-SA-Exim-Scanned: No (on beer.tclug.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2005, David S. Miller wrote:
> Where did you get that Cassini driver btw?  It's not upstream,
> although if it exists it should be.

  Spot rolled it into the most recent Aurora kernel RPMs.  He got the 
driver from me; I in turn got it from Sun's web site.  (It's tagged GPL.)
  Neither Spot nor I care to 'own' the driver, due to both of us lacking 
the hardware it supports, which makes maintenance difficult, at best.

      Jima
