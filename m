Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWCYOK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWCYOK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 09:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWCYOK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 09:10:26 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:33485 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751413AbWCYOKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 09:10:25 -0500
Message-ID: <44254EDC.9020503@drzeus.cx>
Date: Sat, 25 Mar 2006 15:08:28 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, Mark Lord <lkml@rtr.ca>,
       "David J. Wallace" <katana@onetel.com>, sdhci-devel@list.drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [Sdhci-devel] Submission to the kernel?
References: <4419FA7A.4050104@cogweb.net> <200603171042.52589.katana@onetel.com> <441AD537.5080403@rtr.ca> <441AD9C3.2090703@drzeus.cx> <20060317170126.GB32281@kroah.com> <441AEEBB.10104@drzeus.cx> <20060325023942.GC6416@kroah.com> <4424D9CA.7090303@drzeus.cx> <20060325063943.GB22214@kroah.com>
In-Reply-To: <20060325063943.GB22214@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Doh, you are right, sorry about that.  It's a totally different PCI
> device, I should have looked before writing that.
>
> Anyway, thanks again, this is working fine here.
>
>   

Reverse engineering has been rather fun, so given access to some
hardware and enough time, I'll might just produce another driver or two. ;)

Rgds
Pierre

