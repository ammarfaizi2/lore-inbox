Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317592AbSFNL6U>; Fri, 14 Jun 2002 07:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317600AbSFNL6T>; Fri, 14 Jun 2002 07:58:19 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:23812 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S317592AbSFNL6R>; Fri, 14 Jun 2002 07:58:17 -0400
Message-Id: <200206141153.g5EBrtL28937@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: [ANNC] linld 0.95
Date: Fri, 14 Jun 2002 14:54:46 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linld 0.95 is available at

http://port.imtp.ilyichevsk.odessa.ua/linux/vda/linld/

linld095.tar.bz2  22k
linld095devel.tar.bz2  540k
  (includes stripped down Borland C++, ready to use)

Changelog
---------
0.91    Added support for cl=@filename
0.92    VCPI voodoo magic: booting under EMM386 and foes :-)
0.93    Cleanup. cl=@filename: cr/lf will be converted to two spaces
0.94    Ugly workaround for DOS int 15 fn 88 breakage
0.95    Bug squashed: vga=NNN did not like dec numbers, oct/hex only
	Some VCPI comments added
--
vda
