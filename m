Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130219AbRAWPqd>; Tue, 23 Jan 2001 10:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbRAWPqX>; Tue, 23 Jan 2001 10:46:23 -0500
Received: from hera.cwi.nl ([192.16.191.1]:28920 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130219AbRAWPqN>;
	Tue, 23 Jan 2001 10:46:13 -0500
Date: Tue, 23 Jan 2001 16:46:07 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101231546.QAA216375.aeb@vlet.cwi.nl>
To: adilger@turbolinux.com, hpa@zytor.com
Subject: Re: Partition IDs in the New World TM
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:

: What would be wrong with changing the kernel to skip the first page
: of swap, and allowing us to put a signature there?

Swap space already has a signature. Read mkswap(8).
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
