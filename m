Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWCUEND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWCUEND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 23:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWCUEND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 23:13:03 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:3046 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965016AbWCUENB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 23:13:01 -0500
Date: Tue, 21 Mar 2006 13:11:53 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH: 017/017]Memory hotplug for new nodes v.4.(arch_register_node() for ia64)
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
In-Reply-To: <1142872744.10906.125.camel@localhost.localdomain>
References: <20060320183634.7E9C.Y-GOTO@jp.fujitsu.com> <1142872744.10906.125.camel@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060321130425.E477.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2006-03-20 at 18:57 +0900, Yasunori Goto wrote:
> > Current i386's code treats "parent node" in arch_register_node(). 
> > But, IA64 doesn't need it.
> 
> I'm not sure I understand.  What do you mean by "treats"?

Oops. My English may be wrong. :-(
I mean that i386 seems trying to make relationship of parent and child
among each node.

-- 
Yasunori Goto 


