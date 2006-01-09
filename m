Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWAIMgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWAIMgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 07:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWAIMgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 07:36:16 -0500
Received: from i5-7.dnslinks.net ([66.98.167.159]:27790 "HELO ip01-web5.net")
	by vger.kernel.org with SMTP id S1751294AbWAIMgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 07:36:15 -0500
Message-ID: <63513.203.101.32.152.1136810517.squirrel@66.98.166.28>
Date: Mon, 9 Jan 2006 12:41:57 -0000 (UTC)
Subject: REG: problem i am facing
From: balamurugan@sahasrasolutions.com
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

i am using Fedora 1.0 and i am using kernel-2.6.15 and i am using
arm-linux-3.4.1 to cross compile, i am facing the problem while i am make
the compilation , in make menuconfig it will compiled correctly but we
make it compile it will showing one error as

fs/built-in.o(.data+0x22c4): undefined reference to `adfspart_check_ICS'
fs/built-in.o(.data+0x22c8): undefined reference to `adfspart_check_POWERTEC'
fs/built-in.o(.data+0x22cc): undefined reference to `adfspart_check_EESOX'
fs/built-in.o(.data+0x22d0): undefined reference to `adfspart_check_CUMANA'
fs/built-in.o(.data+0x22d4): undefined reference to `adfspart_check_ADFS'
make: *** [.tmp_vmlinux1] Error 1

pls give the solution for this problem ASAP , because i am now compiling
the ting u pls support us.

thanks and regards
