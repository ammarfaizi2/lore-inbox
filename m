Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVIJOFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVIJOFe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 10:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVIJOFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 10:05:34 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:49814 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1750914AbVIJOFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 10:05:34 -0400
Date: Sat, 10 Sep 2005 16:05:32 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13: Badness in send_IPI_mask_bitmask at arch/i386/kernel/smp.c:168
Message-ID: <20050910140532.GA32331@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badness in send_IPI_mask_bitmask at arch/i386/kernel/smp.c:168

See www.frankvm.com/tmp/badness-smp-168.jpg for the full trace

This _might_ have some relationship with the time anomalies seen on this machine.

Hardware: AMD Athlon X2 (SMP, i386). 

-- 
Frank
