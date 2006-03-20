Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWCTQkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWCTQkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWCTQke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:40:34 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:58323 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964871AbWCTQkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:40:32 -0500
Subject: Re: [PATCH: 017/017]Memory hotplug for new nodes
	v.4.(arch_register_node() for ia64)
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060320183634.7E9C.Y-GOTO@jp.fujitsu.com>
References: <20060317163911.C659.Y-GOTO@jp.fujitsu.com>
	 <1142618434.10906.99.camel@localhost.localdomain>
	 <20060320183634.7E9C.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 08:39:04 -0800
Message-Id: <1142872744.10906.125.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 18:57 +0900, Yasunori Goto wrote:
> Current i386's code treats "parent node" in arch_register_node(). 
> But, IA64 doesn't need it.

I'm not sure I understand.  What do you mean by "treats"?

-- Dave

