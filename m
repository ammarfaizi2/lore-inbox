Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVLLGY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVLLGY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 01:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVLLGY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 01:24:28 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:61094 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751156AbVLLGY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 01:24:27 -0500
Date: Sun, 11 Dec 2005 22:24:04 -0800
From: Paul Jackson <pj@sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: akpm@osdl.org, ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org,
       rth@twiddle.net, davej@redhat.com, zwane@arm.linux.org.uk, ak@suse.de,
       ashok.raj@intel.com
Subject: Re: [PATCH] alpha build pm_power_off hack
Message-Id: <20051211222404.d35f990c.pj@sgi.com>
In-Reply-To: <m1y82qany7.fsf@ebiederm.dsl.xmission.com>
References: <20051211232428.18286.40968.sendpatchset@sam.engr.sgi.com>
	<m1y82qany7.fsf@ebiederm.dsl.xmission.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> Taking a quick glance at alpha causes me to think we always
> want pm_power_off to be non null on alpha.

So I presume you think that some alpha person should write
such a function?

I can't quite guess whether you are agreeing with my patch,
or disagreeing with it.

At the very least, I don't want to leave the crosstools build
of alpha with a default config broken.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
