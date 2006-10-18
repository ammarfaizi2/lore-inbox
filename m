Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWJRM5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWJRM5f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 08:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbWJRM5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 08:57:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42981 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030195AbWJRM5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 08:57:34 -0400
Subject: Re: [PATCH] Undeprecate the sysctl system call
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Cal Peake <cp@absolutedigital.net>, Andrew Morton <akpm@osdl.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200610181441.51748.ak@suse.de>
References: <453519EE.76E4.0078.0@novell.com>
	 <p737iyxdfiz.fsf@verdi.suse.de>
	 <1161173741.9363.22.camel@localhost.localdomain>
	 <200610181441.51748.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 13:59:42 +0100
Message-Id: <1161176382.9363.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-18 am 14:41 +0200, ysgrifennodd Andi Kleen:
> It's less work long term, mostly because all the rejects for sysctl.h will 
> go away. And it's more compatible than just removing sysctl(2) completely.

What rejects for sysctl.h, nobody is going to add new entries to
sysctl(2) so there will be no rejects.


