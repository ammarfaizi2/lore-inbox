Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWHJRaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWHJRaz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422641AbWHJRaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:30:55 -0400
Received: from xenotime.net ([66.160.160.81]:62682 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422637AbWHJRay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:30:54 -0400
Date: Thu, 10 Aug 2006 10:33:36 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Mingming Cao <cmm@us.ibm.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/5] Register ext3dev filesystem
Message-Id: <20060810103336.ce80c80c.rdunlap@xenotime.net>
In-Reply-To: <20060810092021.GB11361@harddisk-recovery.com>
References: <1155172642.3161.74.camel@localhost.localdomain>
	<20060810092021.GB11361@harddisk-recovery.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 11:20:22 +0200 Erik Mouw wrote:

> On Wed, Aug 09, 2006 at 06:17:22PM -0700, Mingming Cao wrote:
> > Register ext4 filesystem as ext3dev filesystem in kernel.
> 
> Why confuse users with the name "ext3dev"? If a filesystem lives in
> fs/blah/, it's registered as "blah" and can be mounted with "-t blah".
> Just register the filesystem as "ext4" and mark it "EXPERIMENTAL" in
> Kconfig.

Yes, please.

---
~Randy
