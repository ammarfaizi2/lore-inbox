Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbVHKO6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbVHKO6U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbVHKO6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:58:20 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:18338 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1751034AbVHKO6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:58:19 -0400
Date: Thu, 11 Aug 2005 18:57:59 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: Greg KH <greg@kroah.com>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: S3 wakeup broken by one commit (was Re: bisect gives strange answer)
Message-ID: <20050811185759.A18818@jurassic.park.msu.ru>
References: <20050811183008.A18655@jurassic.park.msu.ru> <E1E3E98-0007D2-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1E3E98-0007D2-00@skye.ra.phy.cam.ac.uk>; from sanjoy@mrao.cam.ac.uk on Thu, Aug 11, 2005 at 03:35:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 03:35:02PM +0100, Sanjoy Mahajan wrote:
> Right, it is fixed.

Maybe Greg didn't know that - if so, I don't think this
test is necessary.

Ivan.
