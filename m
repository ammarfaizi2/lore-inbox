Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317875AbSGRB7m>; Wed, 17 Jul 2002 21:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317856AbSGRB7m>; Wed, 17 Jul 2002 21:59:42 -0400
Received: from keyaki.cc.u-tokai.ac.jp ([150.7.3.4]:30950 "HELO
	keyaki.cc.u-tokai.ac.jp") by vger.kernel.org with SMTP
	id <S317875AbSGRB7l>; Wed, 17 Jul 2002 21:59:41 -0400
Date: Thu, 18 Jul 2002 11:01:47 +0900
From: Naohiko Shimizu <nshimizu@keyaki.cc.u-tokai.ac.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Super Page added support for sparc64 in addition to the alpha
Message-Id: <20020718110147.606b0737.nshimizu@keyaki.cc.u-tokai.ac.jp>
Organization: Tokai University
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-vine-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I added sparc64 support to the Linux Super Page kernel patch.
Because I don't have any sparc machine yet, I completely rely on
other testers. They reported me that it speedup about 2 times
for the large matrix transpose benchmark.

In this patch, I am going to integrate the i386 port.
But it is far from complete. I have a working patch for i386
by my student which can not be integrated with the other ports.
Then the current i386 port is written from scratch by myself.
If someone can help me for the i386 port, I will appreciate his concern.

The project home page is:

http://shimizu-lab.dt.u-tokai.ac.jp/lsp.html

Regards,
-- 

Naohiko Shimizu
Department of Communications Engineering,
School of Information Technology and Electronics, Tokai University
1117 Kitakaname Hiratsuka 259-1292 Japan
TEL.+81-463-58-1211(ext. 4084) FAX.+81-463-58-8320
http://shimizu-lab.dt.u-tokai.ac.jp/

