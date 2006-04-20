Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWDTQ2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWDTQ2s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWDTQ2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:28:48 -0400
Received: from xenotime.net ([66.160.160.81]:57288 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751125AbWDTQ2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:28:47 -0400
Date: Thu, 20 Apr 2006 09:31:12 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Emmanuel Fleury <emmanuel.fleury@labri.fr>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [libata] atapi_enabled problem
Message-Id: <20060420093112.1ebbac16.rdunlap@xenotime.net>
In-Reply-To: <4447AD52.60402@labri.fr>
References: <44477D93.50501@labri.fr>
	<20060420082852.f679a376.rdunlap@xenotime.net>
	<4447AD52.60402@labri.fr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2006 17:48:34 +0200 Emmanuel Fleury wrote:

> Hi Randy.
> 
> Randy.Dunlap wrote:
> > 
> > Yes, it should and it has worked for quite a few people in the past.
> > I suspect something more like a typo.  Anyway, recent kernels
> > (after 2.6.16, so 2.6.17-rc*) already have atapi_enabled set to 1.
> 
> My mistake, I forgot to say I was using 2.6.16.2. Maybe this
> atapi_enabled=1 does appear only in 2.6.17-rc* ?

Yes, it's not in the stable series, just in 2.6.17-rc*.

> Anyway, setting atapi_enabled to '1' in the future releases should solve
> my problem. So, I guess that this isn't a bug after all (just a
> difficult transition :).

Hopefully it's behind us then...

---
~Randy
