Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264773AbUEaUWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264773AbUEaUWI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 16:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUEaUWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 16:22:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11487 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264773AbUEaUWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 16:22:05 -0400
Date: Mon, 31 May 2004 22:21:53 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
       "Matthew J. Fanto" <mattjf@uncompiled.com>
Subject: [2.6 patch] s/integer/int/ in kconfig-language.txt
Message-ID: <20040531202153.GA25501@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial documentation patch below was originally sent by Matthew J. 
Fanto <mattjf@uncompiled.com> some months ago.

Please apply
Adrian


--- linux-2.6.7-rc1-mm1-full/Documentation/kbuild/kconfig-language.txt.old	2004-05-31 22:19:09.000000000 +0200
+++ linux-2.6.7-rc1-mm1-full/Documentation/kbuild/kconfig-language.txt	2004-05-31 22:19:24.000000000 +0200
@@ -48,7 +48,7 @@
 A menu entry can have a number of attributes. Not all of them are
 applicable everywhere (see syntax).
 
-- type definition: "bool"/"tristate"/"string"/"hex"/"integer"
+- type definition: "bool"/"tristate"/"string"/"hex"/"int"
   Every config option must have a type. There are only two basic types:
   tristate and string, the other types are based on these two. The type
   definition optionally accepts an input prompt, so these two examples
