Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbWIWBL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbWIWBL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 21:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbWIWBL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 21:11:57 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:17030 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965078AbWIWBL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 21:11:56 -0400
Date: Sat, 23 Sep 2006 10:11:37 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: akpm@osdl.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com
Subject: Re: [BUGFIX][PATCH] cpu to node relationship fixup take2 [1/2]
 acpi_map_cpu2node
Message-Id: <20060923101137.2ad702f0.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060923100603.52db1f5d.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060922152447.42a83860.kamezawa.hiroyu@jp.fujitsu.com>
	<20060922170604.745d662a.akpm@osdl.org>
	<20060923100603.52db1f5d.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 10:06:03 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> > What I have now is:
> > 
> > cpu-to-node-relationship-fixup-take2.patch
> > cpu-to-node-relationship-fixup-map-cpu-to-node.patch
> > 
> > I shall send those patches in reply to this email.  Please confirm that
> > these are correct, sufficient, complete, etc.
> > 
> will do.
> 
Thank you, Andrew-san. I confirmed that all pathces I need was included in your
replied e-mails.

Regards,
-Kame


