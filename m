Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271634AbRHPTjS>; Thu, 16 Aug 2001 15:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271632AbRHPTjG>; Thu, 16 Aug 2001 15:39:06 -0400
Received: from c1765315-a.mckiny1.tx.home.com ([65.10.75.71]:31753 "EHLO
	aruba.maner.org") by vger.kernel.org with ESMTP id <S271630AbRHPTi5> convert rfc822-to-8bit;
	Thu, 16 Aug 2001 15:38:57 -0400
Subject: Alpha compile on 2.4.9
Date: Thu, 16 Aug 2001 14:39:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <C033B4C3E96AF74A89582654DEC664DB54DC@aruba.maner.org>
content-class: urn:content-classes:message
Thread-Topic: Alpha compile on 2.4.9
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
Thread-Index: AcEmix76P1/uWl2/Ti+ioVpOHpl9mg==
From: "Donald Maner" <donjr@maner.org>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello..

	I'm trying to compile 2.4.9 on an SX164 board.  I am still
getting a failure on pc_keyb.c  

pc_keyb.c: In function `pckbd_rate':
pc_keyb.c:611: storage size of `old_rep' isn't known
pc_keyb.c:612: sizeof applied to an incomplete type
pc_keyb.c:614: sizeof applied to an incomplete type
pc_keyb.c:615: sizeof applied to an incomplete type
pc_keyb.c:611: warning: unused variable `old_rep'
make[3]: *** [pc_keyb.o] Error 1

Please see my earlier email about the issue on 2.4.9-pre3.  If more
information is needed, please ask.

Thanks.
Donald
