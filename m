Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWDTXul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWDTXul (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWDTXul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:50:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57529 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932140AbWDTXuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:50:40 -0400
Date: Thu, 20 Apr 2006 16:49:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: pwil3058@bigpond.net.au, suresh.b.siddha@intel.com, efault@gmx.de,
       nickpiggin@yahoo.com.au, mingo@elte.hu, kernel@kolivas.org,
       kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] smpnice: don't consider sched groups which are lightly
 loaded for balancing
Message-Id: <20060420164936.5988460d.akpm@osdl.org>
In-Reply-To: <20060420095408.A10267@unix-os.sc.intel.com>
References: <20060328185202.A1135@unix-os.sc.intel.com>
	<442A0235.1060305@bigpond.net.au>
	<20060329145242.A11376@unix-os.sc.intel.com>
	<442B1AE8.5030005@bigpond.net.au>
	<20060329165052.C11376@unix-os.sc.intel.com>
	<442B3111.5030808@bigpond.net.au>
	<20060401204824.A8662@unix-os.sc.intel.com>
	<442F7871.4030405@bigpond.net.au>
	<20060419182444.A5081@unix-os.sc.intel.com>
	<444719F8.2050602@bigpond.net.au>
	<20060420095408.A10267@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>
> updated patch appended. thanks.

Where are we up to with smpnice now?  Are there still any known
regressions/problems/bugs/etc?  Has sufficient testing been done for us to
know this?

Thanks.
