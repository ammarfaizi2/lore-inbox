Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbRAAVI6>; Mon, 1 Jan 2001 16:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129704AbRAAVIt>; Mon, 1 Jan 2001 16:08:49 -0500
Received: from srv12-sao.sao.terra.com.br ([200.246.248.67]:25863 "EHLO
	srv12-sao.sao.terra.com.br") by vger.kernel.org with ESMTP
	id <S129604AbRAAVIh>; Mon, 1 Jan 2001 16:08:37 -0500
From: Rafael Diniz <rafael2k@terra.com.br>
Reply-To: rafael2k@terra.com.br
To: linux-kernel@vger.kernel.org
Subject: PC-speaker control 
Date: Mon, 1 Jan 2001 18:30:37 -0200
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01010118360105.00896@rafael>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Is there a way to control the PC-speaker with the Linux kernel 2.2?
I want to disable it.
I guy told me that with this assembly code I can disable it:
	in al , 97
	and al,253
	out 97,al
Linux 2.4 will have any syscall to do this?

Thanks
Rafael Diniz
Brazil
=================================================
Conectiva Linux 6.0 (2.2.17)  XFree86-4.0.1
PII 233mhz 96Mb ram
SB16, USR56k, S3 VirgeDX/GX 4Mb, CD creative48X 
HDa 10Gb Quantum  HDb 4.1Gb Fugitsu
MSX2.0 256k MegaRam 256k Mapper 128k Vram
MSX is the future
=================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
