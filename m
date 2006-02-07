Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbWBGM3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWBGM3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWBGM3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:29:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57257 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965020AbWBGM3P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:29:15 -0500
Subject: Re: Broken NFS (perhaps Cache invalidation bug ?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "L. D. Marks" <L-marks@northwestern.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GHP.4.63.0602062050460.3104@risc4.numis.northwestern.edu>
References: <Pine.GHP.4.63.0602062038470.3104@risc4.numis.northwestern.edu>
	 <Pine.GHP.4.63.0602062050460.3104@risc4.numis.northwestern.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Feb 2006 12:31:22 +0000
Message-Id: <1139315482.18391.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-02-06 at 20:52 -0600, L. D. Marks wrote:
> I should have added the kernel: 2.6.9-22.0.2.ELsmp #1 SMP with 
> nfs-utils-1.0.6-65.EL4

Vendor kernels diverge quite a bit from the base tree (because they
freeze a kernel and backport the critical fixes from thereon). So really
you are best advised to ask your vendor (Red Hat or Centos or whoever)
rather than ask here for that kernel.

Alan

