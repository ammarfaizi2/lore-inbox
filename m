Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268444AbRGaH5S>; Tue, 31 Jul 2001 03:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266949AbRGaH46>; Tue, 31 Jul 2001 03:56:58 -0400
Received: from tachyon.gw.ansto.gov.au ([137.157.8.253]:20238 "EHLO
	tachyon.gw.ansto.gov.au") by vger.kernel.org with ESMTP
	id <S268444AbRGaH4s>; Tue, 31 Jul 2001 03:56:48 -0400
Message-Id: <200107310755.RAA14420@hadron.ansto.gov.au>
From: Robert Cawley <rjc@ansto.gov.au>
To: laughing@shared-source.org
Cc: linux-kernel@vger.kernel.org
Reply-To: rjc@ansto.gov.au
Subject: Re: Linux 2.4.7-ac3
Date: Tue, 31 Jul 2001 17:55:36 +1000 (EST)
X-Mailer: XCmail 1.2 - with PGP support, PGP engine version 0.5 (Linux)
X-Mailerorigin: http://www.fsai.fh-trier.de/~schmitzj/Xclasses/XCmail/
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Alan Cox <laughing@shared-source.org> wrote: 
>2.4.7-ac3 

make[1]: Entering directory `/usr/src/linux-2.4.7-ac3/arch/i386/kernel'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.7-ac3/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe  -march=i686    -c -o traps.o
traps.c
{standard input}: Assembler messages:
{standard input}:430: Error: suffix or operands invalid for `jmp'
{standard input}:516: Error: suffix or operands invalid for `jmp'
{standard input}:600: Error: suffix or operands invalid for `jmp'
{standard input}:684: Error: suffix or operands invalid for `jmp'
{standard input}:774: Error: suffix or operands invalid for `jmp'
{standard input}:849: Error: suffix or operands invalid for `jmp'
{standard input}:931: Error: suffix or operands invalid for `jmp'
{standard input}:1002: Error: suffix or operands invalid for `jmp'
{standard input}:1073: Error: suffix or operands invalid for `jmp'
{standard input}:1144: Error: suffix or operands invalid for `jmp'
{standard input}:1215: Error: suffix or operands invalid for `jmp'
{standard input}:1295: Error: suffix or operands invalid for `jmp'
make[1]: *** [traps.o] Error 1

gcc is egcs-2.91.66

Robert Cawley
ANSTO, PMB 1 Menai 2234, NSW, Australia
Phone: +61 2 9717 3049     Fax: +61 2 9717 9525
Email: rjc@ansto.gov.au






