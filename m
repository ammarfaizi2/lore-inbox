Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUHINsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUHINsG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUHINsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:48:06 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:35560 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266569AbUHINr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:47:59 -0400
Subject: AES assembler optimizations
From: Bob Deblier <bob.deblier@telenet.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1092059277.4332.8.camel@orion>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 15:47:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just picked up on KernelTrap that there were some problems with
optimized AES code; if you wish, I can provide my own LGPL licensed (or
I can relicense them for you under GPL), as included in the BeeCrypt
Cryptography Library.

I have generic i586 code and SSE-optimized code available in GNU
assembler format. Latest version is always available on SourceForge
(http://sourceforge.net/cvs/?group_id=8924).

Please cc: me for responses, as I'm not a list subscriber.

Sincerely,

Bob Deblier

