Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbUDBCv4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbUDBCvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:51:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:39358 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263141AbUDBCvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:51:51 -0500
Date: Thu, 1 Apr 2004 18:51:48 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, andrea@suse.de,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401185148.B21045@build.pdx.osdl.net>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040401173034.16e79fee.akpm@osdl.org> <20040401175914.A22989@build.pdx.osdl.net> <20040402020915.GO18585@dualathlon.random> <20040401183026.6844597a.akpm@osdl.org> <20040401183312.Z21045@build.pdx.osdl.net> <20040401184507.1f01920d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040401184507.1f01920d.akpm@osdl.org>; from akpm@osdl.org on Thu, Apr 01, 2004 at 06:45:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Well the message I'm receiving is that the userspace capability
> infrastructure is a decrepit mess which nobody is fixing or maintaining.
> 
> Certainly, if we could arrange for pam_cap to be fixed and proselytized
> that would be even better than bolting new workalike code into login and
> su.

Very true.  I don't know who's maintaining that code, and the libcap
maintainer is not really touching that code either.  /me looks about for
some spare round tuits or volunteers.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
