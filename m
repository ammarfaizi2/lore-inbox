Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbTEBV5W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 17:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTEBV5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 17:57:22 -0400
Received: from dp.samba.org ([66.70.73.150]:14014 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263186AbTEBV5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 17:57:20 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16050.60554.651489.795368@argo.ozlabs.ibm.com>
Date: Sat, 3 May 2003 08:09:14 +1000
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] fix mach64_gx.c
In-Reply-To: <Pine.LNX.4.44.0305022106110.15173-100000@phoenix.infradead.org>
References: <16050.3732.615164.697680@argo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0305022106110.15173-100000@phoenix.infradead.org>
X-Mailer: VM 7.14 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons writes:

>    Has anyone tested this chipset on a PPC 64?

There aren't any PPC64 boxes with this chipset (ATI Mach64 GX), since
all past and current PPC64 boxes are IBM servers.  I suppose one could
find an old ATI Mach64 PCI card and put it in a PPC64 box, but I don't
know why you would do that instead of putting in a PCI radeon or
something. :)

Regards,
Paul.
