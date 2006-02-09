Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWBIPTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWBIPTQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 10:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWBIPTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 10:19:16 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:5614 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S932501AbWBIPTP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 10:19:15 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Matthew Wilcox <matthew@wil.cx>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Keith Owens'" <kaos@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let IA64_GENERIC select more stuff
References: <20060208035112.GM3524@stusta.de>
	<200602080552.k185q9g07813@unix-os.sc.intel.com>
	<20060208115946.GN3524@stusta.de> <yq0d5hym0lq.fsf@jaguar.mkp.net>
	<20060208213825.GQ3524@stusta.de> <yq0zml0lmmg.fsf@jaguar.mkp.net>
	<20060209131802.GE1593@parisc-linux.org>
	<yq0r76cll25.fsf@jaguar.mkp.net> <20060209141627.GD3524@stusta.de>
From: Jes Sorensen <jes@sgi.com>
Date: 09 Feb 2006 10:19:13 -0500
In-Reply-To: <20060209141627.GD3524@stusta.de>
Message-ID: <yq0irrolfv2.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adrian" == Adrian Bunk <bunk@stusta.de> writes:

Adrian> A patch is already available:

Adrian> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/
Adrian> 2.6.16-rc2/2.6.16-rc2-mm1/broken-out/
Adrian> remove-isa-legacy-functions-drivers-net-hp100c.patch

No problem, Al's patch looks a better solution than mine. So lets
ignore that part of my patch.

Tony is it ok for you to just ignore that part of the patch and apply
the rest? If not I can send you an updated patch.

Thanks,
Jes
