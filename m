Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270993AbTGPUkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271010AbTGPUku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:40:50 -0400
Received: from sponsa.its.UU.SE ([130.238.7.36]:16126 "EHLO sponsa.its.uu.se")
	by vger.kernel.org with ESMTP id S270993AbTGPUkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:40:49 -0400
Date: Wed, 16 Jul 2003 22:55:26 +0200 (MEST)
Message-Id: <200307162055.h6GKtQl9027858@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: andrew.grover@intel.com, hugh@veritas.com, len.brown@intel.com
Subject: RE: ACPI patches updated (20030714)
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003 13:36:10 -0700, "Grover, Andrew" wrote:
> > From: Mikael Pettersson [mailto:mikpe@csd.uu.se] 
> 
> > Concerning code size, the 70K number in ACPI's Kconfig help is
> > out of date. A minimal ACPI (all user-selectable suboptions
> > disabled) adds 145K to my 2.6.0-test1 kernel.
> 
> Are you talking to the compressed or uncompressed kernel? Maybe we got
> it backwards, but the 70K number was the bzImage size difference.
> (Actually I just tried it again. We're 80K now. I blame gcc. ;-))

Uncompressed: size vmlinux. gcc-3.2.2.
