Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUG0Jcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUG0Jcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 05:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUG0JbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 05:31:23 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:22779 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261451AbUG0J3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 05:29:39 -0400
Date: Tue, 27 Jul 2004 05:33:08 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, shaohua.li@intel.com, yi.zhu@intel.com,
       Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH][2.4/2.6] Quiesce after changing ACPI idle thread
In-Reply-To: <Pine.LNX.4.58.0407222208000.22029@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0407270531260.23985@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0407221055391.19190@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0407221123480.19190@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0407222208000.22029@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2004, Zwane Mwaikambo wrote:

> Marcelo, i'm full of shit obviously synchronize_kernel() won't work on
> 2.4 hmmm, i'll see what to do about that.

Ok Marcelo, don't worry about this one, for this particular case Len says
we should leave it as is.

Thanks,
	Zwane
