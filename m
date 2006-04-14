Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWDNS4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWDNS4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 14:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWDNS4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 14:56:09 -0400
Received: from lixom.net ([66.141.50.11]:44459 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1751411AbWDNS4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 14:56:08 -0400
Date: Fri, 14 Apr 2006 13:55:46 -0500
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, plush@optonline.net
Subject: Re: [PATCH] [1/2] POWERPC: IOMMU support for honoring dma_mask
Message-ID: <20060414185546.GA24769@pb15.lixom.net>
References: <20060413020559.GC24769@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413020559.GC24769@pb15.lixom.net>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 09:05:59PM -0500, Olof Johansson wrote:

> Since time is somewhat of essense (if 2.6.17 is still an option), I went
> for the choice of sending now and follow up with a small bugfix later
> in case something shows up, especially since quick regression tests seem
> ok.

FYI, I now have a positive test report from a bcm43xx user with a 1.5GB G5.
(Thanks for testing this, Marc!).


-Olof
