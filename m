Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWHKXAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWHKXAT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 19:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWHKXAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 19:00:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22412 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751232AbWHKXAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 19:00:17 -0400
Date: Fri, 11 Aug 2006 16:00:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Alex Tomas <alex@clusterfs.com>, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
Message-Id: <20060811160002.b2afbec3.akpm@osdl.org>
In-Reply-To: <20060811135737.1abfa0f6.rdunlap@xenotime.net>
References: <1155172827.3161.80.camel@localhost.localdomain>
	<20060809233940.50162afb.akpm@osdl.org>
	<m37j1hlyzv.fsf@bzzz.home.net>
	<20060811135737.1abfa0f6.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 13:57:37 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Thu, 10 Aug 2006 13:29:56 +0400 Alex Tomas wrote:
> 
> >  AM> - The existing comments could benefit from some rework by a
> >  AM> native English speaker.
> > 
> > could someone assist here, please?
> 
> See if this helps.

Thanks, Randy.  The Kconfig help text could do with some help too, if
you're feeling keen..  
