Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129219AbQKEXLF>; Sun, 5 Nov 2000 18:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129928AbQKEXKy>; Sun, 5 Nov 2000 18:10:54 -0500
Received: from pallas.veritas.com ([204.177.156.25]:65422 "EHLO
	pallas.veritas.com") by vger.kernel.org with ESMTP
	id <S129219AbQKEXKl>; Sun, 5 Nov 2000 18:10:41 -0500
Date: Mon, 6 Nov 2000 04:39:23 +0530 (IST)
From: Sushil Agarwal <sushil@veritas.com>
To: linux-kernel@vger.kernel.org
cc: sushil@veritas.com
Subject: rdtsc to mili secs?
Message-ID: <Pine.SOL.4.05.10011060433030.17401-100000@vxindia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    According to the Intel Arch. Instruction set reference the
resolution of the "rdtsc" instruction is a clock cycle. How
do I convert this to mili seconds? 

Thanks,
Sushil.   

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
