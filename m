Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317731AbSGVS5p>; Mon, 22 Jul 2002 14:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317754AbSGVS5p>; Mon, 22 Jul 2002 14:57:45 -0400
Received: from hub-r.franken.de ([194.94.249.2]:13839 "EHLO hub-r.franken.de")
	by vger.kernel.org with ESMTP id <S317731AbSGVS5o>;
	Mon, 22 Jul 2002 14:57:44 -0400
Subject: Problems with AMD 768 IDE support
From: Ernst Lehmann <lehmann@acheron.franken.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1027364446.26894.2.camel@hadley>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 22 Jul 2002 21:00:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have here a Dual-Athlon Box, with a AMD760MPX Chipset and AMD768 IDE.

In the base 2.4.18 kernel there seems to be no support for the
IDE-Chipset

So I tried 2.4.19-rc3-ac1 and I got more APIC errors, than I can count
:))

So my question.

Does anybody know where to find a patch for the IDE-Support to the plain
2.4.18 kernel,

or which version of the 2.4.19-rc<x>-ac<x> is stable enough at the
moment to run such a box.

TIA for any help...


-- 

Bye

	Ernst
---------
Ernst Lehmann             Email: lehmann@acheron.franken.de


