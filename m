Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751705AbWCIQyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbWCIQyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWCIQyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:54:11 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:27407 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751705AbWCIQyK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:54:10 -0500
Date: Thu, 9 Mar 2006 16:53:57 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic on PC with broken hard drive, after DMA errors
Message-ID: <20060309165357.GB10572@deprecation.cyrius.com>
References: <5Okau-77g-9@gated-at.bofh.it> <440FA916.5070703@shaw.ca> <20060309151459.GD2891@deprecation.cyrius.com> <1141922743.16745.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141922743.16745.12.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [2006-03-09 16:45]:
> Ancient known problem. I'd be interested if you can however break
> libata and the PATA IDE patches the same way.

I can try, but like I said, the hard drive acts pretty arbitrarily and
won't always fail when I want it to.  Do you know if there's a way to
trigger the problem?  Otherwise I'll just try a couple of times,
but without a good way to trigger the problem I cannot really say if
it's gone with libata.
-- 
Martin Michlmayr
http://www.cyrius.com/
