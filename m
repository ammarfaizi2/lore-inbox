Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136120AbRASBxo>; Thu, 18 Jan 2001 20:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135802AbRASBwy>; Thu, 18 Jan 2001 20:52:54 -0500
Received: from ozob.net ([216.131.4.130]:22168 "EHLO ozob.net")
	by vger.kernel.org with ESMTP id <S132656AbRASBwq>;
	Thu, 18 Jan 2001 20:52:46 -0500
Date: Thu, 18 Jan 2001 19:52:40 -0600 (CST)
From: ebi4 <ebi4@ozob.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre8 video/ohci1394 compile problem
In-Reply-To: <200101182112.f0ILCmZ113705@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.3.96.1010118195113.2374C-100000@ozob.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

video1394.o(.data+0x0): multiple definition of `ohci_csr_rom'
ohci1394.o(.data+0x0): first defined here
make[3]: *** [ieee1394drv.o] Error 1

Compilation fails here.

::::: Gene Imes			     http://www.ozob.net :::::

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
