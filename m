Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKFTdw>; Mon, 6 Nov 2000 14:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129240AbQKFTdm>; Mon, 6 Nov 2000 14:33:42 -0500
Received: from srv1-for.for.zaz.com.br ([200.239.123.1]:20485 "EHLO
	srv1-for.for.zaz.com.br") by vger.kernel.org with ESMTP
	id <S129103AbQKFTd1>; Mon, 6 Nov 2000 14:33:27 -0500
Date: Mon, 6 Nov 2000 16:24:13 -0300
From: forop066@zaz.com.br
Message-Id: <200011061924.QAA31314@srv1-for.for.zaz.com.br>
To: linux-kernel@vger.kernel.org
Subject: Calling module symbols from inside the kernel !
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is it possible to access symbols exported by modules from inside the kernel ?

I put a funtion call inside the kernel code but this funtion must be implemented in a module. I tried export as a module symbol but when i tried to recompile the kernel.. :-(

Warning: implicit declaration of my_funtion
.
.
.
Error: Undefined reference to my_funtion.

How can i fix this mistake!????

Thanks in advance,
Cris Amon.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
