Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288595AbSAVQXD>; Tue, 22 Jan 2002 11:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288767AbSAVQWx>; Tue, 22 Jan 2002 11:22:53 -0500
Received: from [198.17.35.35] ([198.17.35.35]:28356 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S288595AbSAVQWf>;
	Tue, 22 Jan 2002 11:22:35 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2AB8@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: patch to the maintainers file for arpd support
Date: Tue, 22 Jan 2002 08:22:25 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Naur MAINTAINERS MAINTAINERS.orig
--- MAINTAINERS Tue Jan 22 11:17:37 2002
+++ MAINTAINERS.orig    Mon Oct 22 11:37:17 2001
@@ -204,8 +204,8 @@
 S:     Maintained

 ARPD SUPPORT
-P:     Jonathan Layes
-M:     layes@loran.com
+P:     Dana Lacoste
+M:     dana.lacoste@peregrine.com
+W:     http://home.loran.com/~dlacoste/
 L:     linux-net@vger.kernel.org
 S:     Maintained
