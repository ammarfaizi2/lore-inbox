Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSGPLSO>; Tue, 16 Jul 2002 07:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSGPLSN>; Tue, 16 Jul 2002 07:18:13 -0400
Received: from imeil.udg.es ([130.206.45.97]:23982 "EHLO imeil.udg.es")
	by vger.kernel.org with ESMTP id <S315413AbSGPLSM>;
	Tue, 16 Jul 2002 07:18:12 -0400
Date: Tue, 16 Jul 2002 13:23:59 +0200 (CEST)
From: David Gironella Casademont <giro@hades.udg.es>
To: <linux-kernel@vger.kernel.org>
Subject: Cannot enable dma on promise ata 100
Message-ID: <Pine.LNX.4.30.0207161319060.27181-100000@hades.udg.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have promise fastrak tx200, but when i try to enable dma with hdparm -d1
/dev/hda , i have this error HDIO_SET_DMA failed: Operation not permitted

Without dma i have a 1,47Mb/s of buffered disk read, and this is not
normal.

What is happend? I need to change my kernel, i use 2.4.18-bf24, from
debian woody 3.0Beta.


Thk.
Giro




