Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUDHMrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 08:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUDHMrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 08:47:53 -0400
Received: from gwbw.xs4all.nl ([213.84.100.200]:26758 "EHLO
	laptop.blackstar.nl") by vger.kernel.org with ESMTP id S261181AbUDHMrw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 08:47:52 -0400
Subject: 2.6.3: Kernel stops decompressing without keyboard attached
From: Bas Vermeulen <bvermeul@blackstar.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1081428469.1551.10.camel@laptop.blackstar.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 08 Apr 2004 14:47:50 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having some problems with my Dual Pentium Pro 200 MHz box; It stops
decompressing the kernel and hangs if I have no keyboard attached to it.

If a keyboard is attached, everything works ok. Has anyone else seen
anything like this, and if so, how can this be fixed?

Relevant information:

Dual Pentium Pro 200 MHz on a Micronics W6-Li board.
Kernel 2.6.3 (but will try later versions)
384 MB of ECC RAM

If you need any more information, dmesg output or otherwise,
let me know and I'll provide.

Hope someone can help me out,

Bas Vermeulen

