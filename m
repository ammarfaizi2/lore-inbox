Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266327AbUGUQlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUGUQlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 12:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUGUQlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 12:41:08 -0400
Received: from aun.it.uu.se ([130.238.12.36]:20633 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266327AbUGUQlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 12:41:06 -0400
Date: Wed, 21 Jul 2004 18:40:48 +0200 (MEST)
Message-Id: <200407211640.i6LGem6o025200@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: andyb@chainsaw.com, linux-kernel@vger.kernel.org
Subject: Re: Asus A7M266-D, Linux 2.6.7 and APIC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2004 08:46:11 -0700 (PDT), Andy Biddle wrote:
>Well I had a few minutes this morning, so I swapped CPU0 and 1 and still
>have the same results.  Boots in single proc mode, APIC errors on a
>dual-proc kernel.  (For what it's worth, both CPUs are recognized by the
>BIOS and report "MP capable".
>
>I checked the Asus website and I'm at the latest beta kernel...

No you're not. You have 1011.003, while the latest beta BIOS
is 1011 beta 05.

ftp.asuscom.de
pub/ASUSCOM/BIOS/Socket_A/AMD_Chipset/AMD_760_MPX/A7M266-D/
