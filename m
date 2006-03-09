Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWCIQkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWCIQkI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWCIQkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:40:07 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46306 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751705AbWCIQkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:40:06 -0500
Subject: Re: Kernel panic on PC with broken hard drive, after DMA errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060309151459.GD2891@deprecation.cyrius.com>
References: <5Okau-77g-9@gated-at.bofh.it> <440FA916.5070703@shaw.ca>
	 <20060309151459.GD2891@deprecation.cyrius.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 09 Mar 2006 16:45:43 +0000
Message-Id: <1141922743.16745.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-03-09 at 15:14 +0000, Martin Michlmayr wrote:
> on or do you need more information?  I can hook up a serial console
> and try to capture the full log, but I'm not sure I can reproduce this
> kernel panic.  The dying hard drive is quite arbitrary when it comes
> to showing errors or working fine...

Ancient known problem. I'd be interested if you can however break libata
and the PATA IDE patches the same way. 

