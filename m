Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbUCXVEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUCXVEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:04:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:41352 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261921AbUCXVEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:04:45 -0500
Date: Wed, 24 Mar 2004 13:06:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andreas Happe <news_0403@flatline.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm2
Message-Id: <20040324130653.35cab65b.akpm@osdl.org>
In-Reply-To: <slrnc63mc2.18m.news_0403@flatline.ath.cx>
References: <20040323232511.1346842a.akpm@osdl.org>
	<slrnc63mc2.18m.news_0403@flatline.ath.cx>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Happe <news_0403@flatline.ath.cx> wrote:
>
> On 2004-03-24, Andrew Morton <akpm@osdl.org> wrote:
> > -initramfs-search-for-init.patch
> > -initramfs-search-for-init-zombie-fix.patch
> > +initramfs-search-for-init-orig.patch
> >
> >  Go back to the original, simple version of this patch.
> 
> 2.6.5-rc2-mm2 still hangs after:
> | VFS: mounted root (ext3 filesystem) readonly
> | Freeing unused kernel memory: 140kB
> 
> SysRq still works, what information would you need to solve that
> problem?

The sysrq-T output, if possible.  And your .config.
