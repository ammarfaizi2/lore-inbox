Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVATTxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVATTxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVATTxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:53:16 -0500
Received: from almesberger.net ([63.105.73.238]:47122 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261917AbVATTwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:52:23 -0500
Date: Thu, 20 Jan 2005 16:51:50 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH 0/29] overview
Message-ID: <20050120165150.A21510@almesberger.net>
References: <20050120102223.B14297@almesberger.net> <m1vf9s3ozr.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vf9s3ozr.fsf@ebiederm.dsl.xmission.com>; from ebiederm@xmission.com on Thu, Jan 20, 2005 at 12:00:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> To some extent.  It is worth noting that the first 13 of my patches
> are not core functionality they are bug fixes or feature enhancements
> of code that simply have come to be associated with the work on kexec.

Good point. I didn't even think of the low-level parts of the boot
process. I'm more worried about the high-level side. Since GRUB,
not much seems to have happened. I think we should have a much
richer boot environment by now.

We're still not even at the level of functionality typically found
in the boot PROMs of classical Unix workstations, whereas I think
we should have been running circles around them for years already.

So if there was a vote to be cast for getting kexec into mainline
as quickly as possible, you'd certainly have mine :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
