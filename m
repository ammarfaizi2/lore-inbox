Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKURdL>; Tue, 21 Nov 2000 12:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbQKURdB>; Tue, 21 Nov 2000 12:33:01 -0500
Received: from emmi.physik.TU-Berlin.DE ([130.149.160.103]:31502 "EHLO
	emmi.physik.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S129231AbQKURcl>; Tue, 21 Nov 2000 12:32:41 -0500
Date: Tue, 21 Nov 2000 18:02:38 +0100 (CET)
From: Vitali Lieder <vitali@physik.TU-Berlin.DE>
To: linux-kernel@vger.kernel.org
Subject: NVdriver-problem with 2.4.0-test11
Message-ID: <Pine.BSF.4.05.10011211750470.8952-100000@rosa.physik.TU-Berlin.DE>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo!

With new 2.4.0-test11 kernel i have the problem with NVdriver-0.95:

depmod: *** unresolved symbols in /lib/modules/2.4.0-test11/video/NVdriver

/lib/modules/2.4.0-test11/video/Nvdriver:unresolved symbol in put_module_symbol
/lib/modules/2.4.0-test11/video/NVdriver:unresolved symbol in get_module_symbol

Please, could you explain me, how i can find in patch the #define's lines
with this symbols, that was cleaned from kernel, so that i can place that
lines by myself in future.

Thank you !

vitali@physik.tu-berlin.de 
                           or
lieder.cs.tu-berlin.de

Thanks.

  

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
