Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUKBVw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUKBVw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbUKBVlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:41:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:15589 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261458AbUKBVjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:39:41 -0500
Date: Tue, 2 Nov 2004 13:43:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Williams, Mitch A" <mitch.a.williams@intel.com>
Cc: bonding-devel@lists.sourceforge.net, fubar@us.ibm.com,
       ctindel@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix for 802.3ad shutdown issue
Message-Id: <20041102134303.44e715da.akpm@osdl.org>
In-Reply-To: <F3EE2A9EB4576F40AFE238EC0AC04BC504191A10@orsmsx402.amr.corp.intel.com>
References: <F3EE2A9EB4576F40AFE238EC0AC04BC504191A10@orsmsx402.amr.corp.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Williams, Mitch A" <mitch.a.williams@intel.com> wrote:
>
> The patch below fixes a problem with shutting down 802.3ad bonds on the
> 2.6 
> kernel.

I'll fix this patch up and add it to my tree so that it doesn't get lost.

Please fix your email client so that future patches are not wordwrapped,
thanks.
