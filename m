Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVASOZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVASOZu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVASOZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:25:50 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:30737 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261475AbVASOZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:25:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:x-mailer:reply-to:x-priority:message-id:to:mime-version:content-type:content-transfer-encoding;
        b=FqtyDg1ZEsxvz9KQuwg+zIdNj2vKZ5xWHg6kQ9xA7NZofGm5PecBi5qIk2l8nuISk/S+CnvrOy8V62na7pZ7el14IqAqnPb2Sy9qkO/fny8j2uwDuYp8pd8Aqq6DeesqVGhCe5XtMNcvxY+t3V8zLlZIbKGdw/BeR/uhAlSlxL0=
Date: Wed, 19 Jan 2005 16:25:22 +0200
From: Gmail <todor.t@gmail.com>
X-Mailer: The Bat! (v3.0) UNREG / CD5BF9353B3B7091
Reply-To: Gmail <todor.t@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <987426305.20050119162522@gmail.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------------------------------------------------------------
 * Building module-init-tools...
./configure --prefix=/usr --host=i486-slackware-linux --mandir=//usr/share/man --infodir=//usr/share/info --datadir=//usr/share --sysconfdir=//etc --localstatedir=//var/lib --prefix=/ --enable-zlib
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking build system type... i586-pc-linux-gnu
checking host system type... i486-slackware-linux-gnu
checking target system type... i486-slackware-linux-gnu
checking for a BSD-compatible install... /usr/bin/ginstall -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for i486-slackware-linux-strip... no
checking for strip... strip
checking for i486-slackware-linux-gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ANSI C... none needed
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
configure: Adding gcc options: -O2 -mcpu=i686 -pipe -Wunused -Wall
configure: creating ./config.status
config.status: creating Makefile
config.status: executing depfiles commands
Makefile:385: *** missing separator.  Stop.

!!! ERROR: sys-apps/module-init-tools-3.0-r2 failed.
!!! Function src_compile, Line 1980, Exitcode 2
!!! emake module-init-tools failed
!!! If you need support, post the topmost build error, NOT this status message.

phases failed
-------------------------------------------------------------------

[1] When we reach the 'make' command.. it prints that error...
Makefile:385. I'm not familiar at all with this kind of stuff... So I
just CAN'T help myself! And that makes me nervous...

[2]
[3] module-init-tools
[4] Linux version 2.4.26 (root@tree) (gcc version 3.3.4) #6 Mon Jun 14 19:07:27 PDT 2004
[6] bash# make

