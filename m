Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbTKXIGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 03:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTKXIGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 03:06:15 -0500
Received: from gizmo13bw.bigpond.com ([144.140.70.23]:44196 "HELO
	gizmo13bw.bigpond.com") by vger.kernel.org with SMTP
	id S263636AbTKXIGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 03:06:13 -0500
Message-ID: <3FC1BBF1.A4D05AD@eyal.emu.id.au>
Date: Mon, 24 Nov 2003 19:06:09 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.23-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test10 - BINFMT_ELF
References: <Pine.LNX.4.44.0311231804170.17378-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is unusual that a Y/n option includes M in the help text:
...
To compile this as a module, choose M here: the module will be called
binfmt_elf. Saying M or N here is dangerous because some crucial
programs on your system might be in ELF format.

Kernel support for ELF binaries (BINFMT_ELF) [Y/n/?] (NEW) y
...

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
