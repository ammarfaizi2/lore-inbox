Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132611AbRDGIS2>; Sat, 7 Apr 2001 04:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132612AbRDGISI>; Sat, 7 Apr 2001 04:18:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25098 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132611AbRDGIR7>; Sat, 7 Apr 2001 04:17:59 -0400
Subject: Re: Proper way to release binary driver?
To: turcksin@raleigh.ibm.com (Christopher Turcksin)
Date: Sat, 7 Apr 2001 09:18:48 +0100 (BST)
Cc: ebiederm@xmission.com (Eric W. Biederman),
        Brendan.Miller@Dialogic.com (Miller Brendan),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <3ACDE5C5.CEB65D4A@raleigh.ibm.com> from "Christopher Turcksin" at Apr 06, 2001 04:50:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14lnvn-0007AS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We had hoped that MODVERSIONS would allow us to provide a single (or at
> most a few) binary driver. Kernels with even minor version numbers are
> supposed to be stable (even if they are buggy) ie. not have wildly
> changing kernel interfaces.

They have a stable API. THe ABI thing is an irrelevance to free software.
avoiding the ABI compatibility mess is one of the great things free
software lets you do.

Alan

