Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271208AbTG2ImL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 04:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271298AbTG2ImL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 04:42:11 -0400
Received: from indianer.linux-kernel.at ([212.24.125.53]:1258 "EHLO
	indianer.linux-kernel.at") by vger.kernel.org with ESMTP
	id S271208AbTG2ImJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 04:42:09 -0400
Message-Id: <200307290839.h6T8dj72007467@indianer.linux-kernel.at>
From: Oliver Pitzeier <oliver@linux-kernel.at>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Linux v2.6.0-test2
Date: Tue, 29 Jul 2003 10:41:13 +0200
Organization: Linux Kernel Austria
X-Mailer: Oracle Outlook Connector 3.4 40812
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner-Information: Please contact your Internet E-Mail Service Provider for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
[ ... ]
> Various architectures are congealing: sparc64, ia64, alpha, 
> m68k, ppc32, v850 and s390 all had updates. 

Linus, your are making me happy:

[root@track /root]# uname -a; rpm -q gcc; rpm -q glibc; \
> rpm -q modutils; rpm -q initscripts
Linux track.uptime.at 2.6.0-test2 #1 Mon Jul 28 15:18:16 CEST 2003 alpha unknown
gcc-3.1-6
glibc-2.2.4-31
modutils-2.4.21-18
initscripts-5.84.1-1

It works like a charm. :)

It's a AlphaServer 1000A 5/333, EV56, Noritake system.

Best regards,
 Oliver

