Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUBXRT4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbUBXRSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:18:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:9158 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262322AbUBXRR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:17:59 -0500
Date: Tue, 24 Feb 2004 09:10:14 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Carlos Silva" <r3pek@r3pek.homelinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kexec "problem"
Message-Id: <20040224091014.4a605006.rddunlap@osdl.org>
In-Reply-To: <28775.62.229.71.110.1077620541.squirrel@webmail.r3pek.homelinux.org>
References: <20040224160341.GA11739@in.ibm.com>
	<28775.62.229.71.110.1077620541.squirrel@webmail.r3pek.homelinux.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004 11:02:21 -0000 (WET) Carlos Silva wrote:

| hi guys,
| 
| i have just compiled a kernel with the kexec patch. compiled kexec-tools
| and when i try to load a kernel, it gives me this:
| # ./do-kexec.sh /boot/bzImage-2.6.2-g
| kexec_load failed: Invalid argument
| entry       = 0x91764
| nr_segments = 2
| segment[0].buf   = 0x80b3480
| segment[0].bufsz = 1880
| segment[0].mem   = 0x90000
| segment[0].memsz = 1880
| segment[1].buf   = 0x40001008
| segment[1].bufsz = 19795a
| segment[1].mem   = 0x100000
| segment[1].memsz = 19795a
| 
| anyone tried to run kexec and actually did it? i'm trying with kernel 2.6.3

I haven't updated for 2.6.3 yet, or even tested it...
but I'll get to it soon.

--
~Randy
