Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265947AbUGZVhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265947AbUGZVhR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUGZVhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:37:17 -0400
Received: from pop.gmx.de ([213.165.64.20]:28103 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265947AbUGZVhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 17:37:09 -0400
X-Authenticated: #5964578
Date: Mon, 26 Jul 2004 23:36:51 +0200
From: Dexter Filmore <Dexter.Filmore@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: whining noise - possible bug in nForce2 support?
Message-Id: <20040726233651.0cf10aae@shodan.citadel>
Organization: SCHWA Corporation
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't know who else to ask about this: 

Just upgraded my mobo to a ECS N2U400-A nForce2 board, standard MCP
southbridge, latest BIOS.
CPU is AMD Athlon XP 1800+, 2x256MB PC266 RAM.
Kernel version is 2.6.7, tested distros are Slackware 10 and Knoppix 3.4.

Board work alright so far, but as soon as I start a 2.6 kernel, the board will
produce a high pitched whining sound.
This doesn't happen with 2.4 or a wide spread OS from Redmond, only with 2.6.
I tried test kernels without ACPI, APM and such, no success.

Interesting thing: as long as the hard disk has something to do, the noise
vanishes but returns as soon as the disk idles again.

This is way beyond me. Anybody got an idea?

Dex



-- 
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS d--(+)@ s-:+ a- C+++(++++) UL+>++++ P+>++ L+++>++++ E-- W++ N o? K-
w--(---) !O M+ V- PS++(+) PE(-) Y+ PGP(-) t++(---)@ 5 X+(++) R+(++) tv--(+)@ 
b+(+++) DI+++ D G++ e* h>++ r%>* y?
------END GEEK CODE BLOCK------

http://www.againsttcpa.com - nothing fights like the opposition
