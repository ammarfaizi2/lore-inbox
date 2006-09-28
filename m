Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbWI1Vwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWI1Vwv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 17:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbWI1Vwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 17:52:51 -0400
Received: from mail.rucls.net ([65.126.99.146]:58594 "EHLO mail.rucls.net")
	by vger.kernel.org with ESMTP id S1161191AbWI1Vwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 17:52:50 -0400
Date: Thu, 28 Sep 2006 16:52:49 -0500
From: Mark Felder <felderado@gmail.com>
To: Luke-Jr <luke@dashjr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI bridge missing
Message-Id: <20060928165249.ab5b7bbe.felderado@gmail.com>
In-Reply-To: <200609281624.16082.luke@dashjr.org>
References: <200609281624.16082.luke@dashjr.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have Dell Optiplex GX1's at the school district I'm covering at. I can test some stuff out with various live CDs if that would help.


Mark



On Thu, 28 Sep 2006 16:24:15 -0500
Luke-Jr <luke@dashjr.org> wrote:

> This applies to Debian sarge kernels kernel-image-2.4.27-2-686, 2.6.8-3-686, 
> 2.6.16-2-686, and 2.6.17-2-686...
> I am trying to setup a Dell Optiplex GX1p system, which has a daughterboard 
> PCI bridge for its PCI and ISA slots:
> 00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
> 
> However, this bridge is completely ignored and unseen by Linux. It does not 
> show up in lspci or dmesg (as far as I can tell) at all. The daughterboard is 
> plugged in, and the PCI cards on it are powered.
> 
> How could I go about troubleshooting the problem? Has anyone experienced 
> something like this before?
> 
> Thanks,
> 
> Luke-Jr
> 
> P.S. Please CC me if possible.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
