Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbVCDMGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbVCDMGZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbVCDLyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:54:25 -0500
Received: from fire.osdl.org ([65.172.181.4]:45531 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262838AbVCDL1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:27:53 -0500
Date: Fri, 4 Mar 2005 03:26:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: davej@redhat.com, torvalds@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050304032632.0a729d11.akpm@osdl.org>
In-Reply-To: <20050304105247.B3932@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<20050302230634.A29815@flint.arm.linux.org.uk>
	<42265023.20804@pobox.com>
	<Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	<20050303002733.GH10124@redhat.com>
	<20050302203812.092f80a0.akpm@osdl.org>
	<20050304105247.B3932@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Wed, Mar 02, 2005 at 08:38:12PM -0800, Andrew Morton wrote:
>  > Grump.  Have all these regressions received the appropriate level of
>  > visibility on this mailing list?
> 
>  Looking at the http://l4x.org/k/ site, it appears that all -mm versions
>  have broken ARM support with the defconfig, while Linus kernels at least
>  build fine.

It's very much in an arch maintainer's interest to make sure that
cross-compilers are easily obtainable.  Any hints?
