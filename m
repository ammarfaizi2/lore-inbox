Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161129AbWAHCLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbWAHCLe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 21:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbWAHCLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 21:11:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12673 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161129AbWAHCLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 21:11:33 -0500
Date: Sat, 7 Jan 2006 21:11:31 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ppc build failure with 2.6.15-git3
Message-ID: <20060108021131.GV9402@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In file included from include/linux/mman.h:5,
from arch/powerpc/kernel/asm-offsets.c:23:
include/linux/mm.h:448:2: error: #error SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED

		Dave

