Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129311AbRA0CB6>; Fri, 26 Jan 2001 21:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129396AbRA0CBj>; Fri, 26 Jan 2001 21:01:39 -0500
Received: from srv12-sao.sao.terra.com.br ([200.246.248.67]:63244 "EHLO
	srv12-sao.sao.terra.com.br") by vger.kernel.org with ESMTP
	id <S129311AbRA0CBg>; Fri, 26 Jan 2001 21:01:36 -0500
From: Rafael Diniz <rafael2k@terra.com.br>
Reply-To: rafael2k@terra.com.br
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4 hangs on PowerBook 150(m68k)
Date: Fri, 26 Jan 2001 23:52:19 -0200
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <3A7BB6B1.ABF71834@austin.rr.com>
In-Reply-To: <3A7BB6B1.ABF71834@austin.rr.com>
MIME-Version: 1.0
Message-Id: <01012623575600.01138@rafael>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4.0 hangs in my PowerBook 150(m68030 without fpu, 8Mb ram, 122Mb HD
quantum IDE, adb keyboard and mouse) when it is loading the adb driver(after
the scsi driver load).
The 2.2 boot normally, but I can't acess keyboard nor mouse because it does not
have adb support...

Thanks
Rafael Diniz
Brazil
=================================================
Conectiva Linux 6.0 (2.2.17)  XFree86-4.0.1
PII 233mhz 96Mb ram
SB16, USR56k, S3 VirgeDX/GX 4Mb, CD creative48X 
HDa 10Gb Quantum  HDb 4.1Gb Fujitsu
MSX2.0 256k MegaRam 256k Mapper 128k Vram
MSX is the future
=================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
