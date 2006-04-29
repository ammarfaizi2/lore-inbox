Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWD2AVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWD2AVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 20:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWD2AVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 20:21:25 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:39647 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030229AbWD2AVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 20:21:25 -0400
Date: Sat, 29 Apr 2006 09:21:08 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       greg@kroah.com
Subject: Re: [PATCH] catch valid mem range at onlining memory
Message-Id: <20060429092108.42e47940.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060428163409.389e895e.akpm@osdl.org>
References: <20060428114732.e889ad2d.kamezawa.hiroyu@jp.fujitsu.com>
	<20060428163409.389e895e.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2006 16:34:09 -0700
Andrew Morton <akpm@osdl.org> wrote:

> 
> This all looks fairly (but trivially) dependent upon the 64-bit-resource
> patches in Greg's tree.  
yes.

> Greg, were you planning on merging them in the post-2.6.17 flood?
> 

For kdump, I'm glad if it can be mergerd.

-Kame

