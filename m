Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271033AbTG1UeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271041AbTG1UeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:34:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:50391 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271033AbTG1Ucz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:32:55 -0400
Date: Mon, 28 Jul 2003 13:29:56 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test2: gcc-3.3.1 warning.
Message-Id: <20030728132956.4bf55254.rddunlap@osdl.org>
In-Reply-To: <1059396053.442.2.camel@lorien>
References: <1059396053.442.2.camel@lorien>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jul 2003 09:40:53 -0300 Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br> wrote:

| 
| Hi all,
| 
| I'm getting this warning while compiling the 2.6-tes2:
| 
| arch/i386/kernel/reboot.c: In function `machine_restart':
| arch/i386/kernel/reboot.c:261: warning: use of memory input without
| lvalue in asm operand 0 is deprecated

What version of gcc?
I don't see this with gcc 3.2.
Is this something that we need to fix?

--
~Randy
