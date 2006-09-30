Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWI3Rwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWI3Rwy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWI3Rwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:52:54 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:64594 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751339AbWI3Rwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:52:53 -0400
Date: Sat, 30 Sep 2006 20:52:50 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: jdmason@kudzu.us, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH 0 of 4] x86-64: Calgary IOMMU updates
Message-ID: <20060930175250.GT22787@rhun.haifa.ibm.com>
References: <patchbomb.1159605808@rhun.haifa.ibm.com> <200609301807.25238.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609301807.25238.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 06:07:25PM +0200, Andi Kleen wrote:
> On Saturday 30 September 2006 10:43, Muli Ben-Yehuda wrote:
> > Hi Andi,
> > 
> > [resending with proper CC's].
> > 
> > Please apply this Calgary patchset. It fixes one bug
> > (https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=203971, should
> > go to -stable as well) and makes several other updates all of which
> > are safe for 2.6.19. Each patch has a detailed description.
> 
> Merged thanks.
> 
> It would be good if you could use a less weird patch format in the future 
> though. In particular diffstat should be at the end and any other weird
> metadata too. And the Subject shouldn't be wrapped.

Hmpf, silly hg email. Will fix.

Cheers,
Muli

