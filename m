Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132491AbRAMK3w>; Sat, 13 Jan 2001 05:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135812AbRAMK3m>; Sat, 13 Jan 2001 05:29:42 -0500
Received: from smtp-rt-6.wanadoo.fr ([193.252.19.160]:64719 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S132491AbRAMK3b>; Sat, 13 Jan 2001 05:29:31 -0500
Message-ID: <3A602DAE.E213A79F@wanadoo.fr>
Date: Sat, 13 Jan 2001 11:27:59 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.76 [fr] (X11; U; Linux 2.4.1-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre2/3 and Pentium-III not stable
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pentium-III 256Mo
For testing, I try to compile glibc. The start is good.
When the process PID reaches a value around 22000
(variable), all goes wrong. Make gives error messages
such as :

make[2]: *** No rule to make target
`../sysdeps/wordsize-32/bits/wordsi:e.h'
make[2]: *** No rule to make target
`/usr/lib/g#c-lib/i686-pc-linux-gnu/2.95.2/include/stddef.h'
make[2]: *** No rule to make target
`../include/sys/cde&s.h'

The machine doesn't freeze, it is just completely unstable.


------------------------------------------------
 Pierre Rousselet
------------------------------------------------



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
