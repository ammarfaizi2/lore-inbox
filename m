Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTIRNrf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 09:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbTIRNre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 09:47:34 -0400
Received: from sh174.internetdsl.tpnet.pl ([80.55.85.174]:54023 "EHLO
	pbern.biz") by vger.kernel.org with ESMTP id S261267AbTIRNre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 09:47:34 -0400
Date: Thu, 18 Sep 2003 15:46:37 +0200 (CEST)
From: pbern@pbern.biz
X-X-Sender: pbern@farma
To: Matt Bernstein <matt@theBachChoir.org.uk>
cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-ac3
In-Reply-To: <Pine.LNX.4.58.0309181430110.8770@r2-pc.dcs.qmul.ac.uk>
Message-ID: <Pine.LNX.4.56L.0309181545180.1646@farma>
References: <200309152306.h8FN6lF04552@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0309181430110.8770@r2-pc.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Sep 2003, Matt Bernstein wrote:
> >Linux 2.4.22-ac3
> depmod: *** Unresolved symbols in /lib/modules/2.4.22-ac3/kernel/drivers/ide/ide-core.o
> depmod:         ide_wait_hwif_ready
> depmod:         ide_probe_for_drive
> depmod:         ide_probe_reset
> depmod:         ide_tune_drives
> make: *** [_modinst_post] Error 1

i have this problem with 2.4.23-pre4
gcc 3.3.1

Pozdrawiam
Pawel Bernadowski
GG 3377, email kontakt@pbern.biz
