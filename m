Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWIWAGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWIWAGg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWIWAGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:06:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964940AbWIWAGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:06:35 -0400
Date: Fri, 22 Sep 2006 17:06:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: "tony.luck@intel.com" <tony.luck@intel.com>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>, GOTO <y-goto@jp.fujitsu.com>
Subject: Re: [BUGFIX][PATCH] cpu to node relationship fixup take2 [1/2]
 acpi_map_cpu2node
Message-Id: <20060922170604.745d662a.akpm@osdl.org>
In-Reply-To: <20060922152447.42a83860.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060922152447.42a83860.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 15:24:47 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> I rewrote the whoe patch..
> 

Well I don't recall ever having seen a "cpu to node relationship fixup
take1" and I have generally lost the plot regarding these fixes.

What I have now is:

cpu-to-node-relationship-fixup-take2.patch
cpu-to-node-relationship-fixup-map-cpu-to-node.patch

I shall send those patches in reply to this email.  Please confirm that
these are correct, sufficient, complete, etc.

Do you believe these are needed in 2.6.18.x?

Please follow the guidelines in
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt a little more
closely, especially regarding Subject:s

Please bear in mind that I'm sitting on thousands of patches from hundreds
of developers, that I process sometimes hundreds of patches per day and I
am very easily confused.  Retaining consistent and well-thought out
Subject:s and referring to previous patches via their precise Subject:s
really helps, thanks.

