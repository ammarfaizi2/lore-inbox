Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSJ1Cxv>; Sun, 27 Oct 2002 21:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262814AbSJ1Cxv>; Sun, 27 Oct 2002 21:53:51 -0500
Received: from keyaki.cc.u-tokai.ac.jp ([150.7.3.4]:25799 "HELO
	keyaki.cc.u-tokai.ac.jp") by vger.kernel.org with SMTP
	id <S262813AbSJ1Cxv>; Sun, 27 Oct 2002 21:53:51 -0500
Date: Mon, 28 Oct 2002 12:00:08 +0900
From: Naohiko Shimizu <nshimizu@keyaki.cc.u-tokai.ac.jp>
To: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] Transparent SuperPage Support for 2.5.44
Message-Id: <20021028120008.13ce08bf.nshimizu@keyaki.cc.u-tokai.ac.jp>
In-Reply-To: <20021027214050.A7886@dsnt25.mro.cpqcorp.net>
References: <20021028105849.424265cb.nshimizu@keyaki.cc.u-tokai.ac.jp>
	<20021027214050.A7886@dsnt25.mro.cpqcorp.net>
Organization: Tokai University
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Jeff for the fix.
I also needed to add set_pte_raw for sparc64 port.
Revised patch is placed at:

http://shimizu-lab.dt.u-tokai.ac.jp/lsp/super_page-2.5.44_021028-1.patch

-- 
Naohiko Shimizu
Dept. Communications Engineering/Tokai University
1117 Kitakaname Hiratsuka 259-1292 Japan
TEL.+81-463-58-1211(ext. 4084) FAX.+81-463-58-8320
http://shimizu-lab.dt.u-tokai.ac.jp/
