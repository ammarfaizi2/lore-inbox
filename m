Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbRFXAlb>; Sat, 23 Jun 2001 20:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265687AbRFXAlW>; Sat, 23 Jun 2001 20:41:22 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:17675 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id <S265681AbRFXAlG>; Sat, 23 Jun 2001 20:41:06 -0400
Message-ID: <05c701c0fc46$5ac58be0$d55355c2@microsoft>
From: "Alexander V. Bilichenko" <dmor@7ka.mipt.ru>
To: <linux-kernel@vger.kernel.org>
Subject: GCC3.0: Again
Date: Sun, 24 Jun 2001 04:41:06 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1251"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2488.0001
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2488.0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again:

make[3]: Entering directory `/usr/src/linux/net/core'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-tri
graphs -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack
-boundary=2 -march=i686    -c -o datagram.o datagram.c
{standard input}: Assembler messages:
{standard input}:747: Error: Junk `adcl $0xffff' after register
{standard input}:804: Error: Junk `adcl $0xffff' after register
make[3]: *** [datagram.o] Error 1
make[3]: Leaving directory `/usr/src/linux/net/core'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/net/core'
make[1]: *** [_subdir_core] Error 2
make[1]: Leaving directory `/usr/src/linux/net'
make: *** [_dir_net] Error 2


Best regards,
Alexander         mailto:dmor@7ka.mipt.ru

