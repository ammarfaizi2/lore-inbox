Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVBDBYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVBDBYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVBDBUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:20:32 -0500
Received: from mail.tyan.com ([66.122.195.4]:49675 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S263250AbVBDBAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:00:17 -0500
Message-ID: <3174569B9743D511922F00A0C9431423080853BA@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: "'Andi Kleen'" <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc3 x86-64 compile err on suse 9.1
Date: Thu, 3 Feb 2005 17:13:05 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      arch/x86_64/kernel/asm-offsets.s
arch/x86_64/kernel/asm-offsets.c: In function `main':
arch/x86_64/kernel/asm-offsets.c:65: error: invalid application of `sizeof'
to an incomplete type
arch/x86_64/kernel/asm-offsets.c:66: error: dereferencing pointer to
incomplete type
arch/x86_64/kernel/asm-offsets.c:67: error: dereferencing pointer to
incomplete type
make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
make: *** [arch/x86_64/kernel/asm-offsets.s] Error 2
