Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTD3OKP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 10:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTD3OKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 10:10:15 -0400
Received: from franka.aracnet.com ([216.99.193.44]:3001 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261968AbTD3OKO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 10:10:14 -0400
Date: Wed, 30 Apr 2003 07:22:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Wojciech Sobczak <Wojciech.Sobczak@comarch.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: IBM x440 problems on 2.4.20 to 2.4.20-rc1-ac3
Message-ID: <3270000.1051712524@[10.10.2.4]>
In-Reply-To: <01d601c30f17$f3ffadf0$b312840a@nbsobczak>
References: <01d601c30f17$f3ffadf0$b312840a@nbsobczak>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm trying to boot from linux kernel 2.4 tree
> i've installed rh 7.1 dist, but system seems only 3 procesors, so i made
> 2.4.20 kernel with smp without NUMA support and i saw 4 processors. Next
> 2.4.20 with numa support, and system hangs on mounting root filesystem (no
> scsi devices found, ide devices lost interruption, no keyboard found etc
> etc)
> Next 2.4.21-rc1-ac3 without NUMA, 3-processors available
> with NUMA support and summit/exa support and clustered apic support kernel
> boots, found scsi devices but hangs on it with lost interruption, also
> with ide devices and so on
> machine has 4 HT processors and 8GB of RAM
> any ideas or help?
> 
> i don't wat to use 2.5.x kernel.....

SuSE works well, at least the SLES edition does.

I'm not sure that any of the other 2.4 kernels work properly, though I
can't say I've tried the latest updates to other distros - they might work,
but I doubt 7.1 does - that's very old.

M.

