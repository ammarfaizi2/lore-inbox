Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTG1M0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 08:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTG1M0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 08:26:09 -0400
Received: from [200.230.190.107] ([200.230.190.107]:7441 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S263738AbTG1M0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 08:26:07 -0400
Subject: 2.6-test2: gcc-3.3.1 warning.
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Governo Eletronico - SP
Message-Id: <1059396053.442.2.camel@lorien>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 28 Jul 2003 09:40:53 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I'm getting this warning while compiling the 2.6-tes2:

arch/i386/kernel/reboot.c: In function `machine_restart':
arch/i386/kernel/reboot.c:261: warning: use of memory input without
lvalue in asm operand 0 is deprecated

-- 
Luiz Fernando N. Capitulino

<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

