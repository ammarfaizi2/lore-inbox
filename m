Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTIITiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264466AbTIITiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:38:24 -0400
Received: from lidskialf.net ([62.3.233.115]:63446 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S264461AbTIITiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:38:20 -0400
From: Andrew de Quincey <adq@lidskialf.net>
To: Andi Kleen <ak@suse.de>, David Mansfield <lkml@dm.cobite.com>
Subject: Re: ACPI kernel panic at boot on 2.6.0-test5-mm1
Date: Tue, 9 Sep 2003 20:38:19 +0100
User-Agent: KMail/1.5.3
Cc: acpi-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
References: <Pine.LNX.4.44.0309091420000.1412-100000@sol.cobite.com.suse.lists.linux.kernel> <p734qzlkcn3.fsf@oldwotan.suse.de>
In-Reply-To: <p734qzlkcn3.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309092038.19059.adq@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 September 2003 20:03, Andi Kleen wrote:
> David Mansfield <lkml@dm.cobite.com> writes:
> > at acpi_pci_link_calc_penalties
>
> Try this (untested) patch
>
> (2.6 version untested, I tested a similar patch on the 2.4 backport of
> ACPI):
>

Hi, you beat me to it. Just tested your patch on my patched linux-2.6.0-test4. 
Works ok for me.

