Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263545AbTLSTEq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 14:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTLSTEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 14:04:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:23228 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263545AbTLSTEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 14:04:42 -0500
Date: Fri, 19 Dec 2003 11:03:23 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.6.0 EDD enhancements
Message-Id: <20031219110323.35f25aae.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0312191254550.2465-100000@humbolt.us.dell.com>
References: <Pine.LNX.4.44.0312191254550.2465-100000@humbolt.us.dell.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003 12:57:06 -0600 (CST) Matt Domsch <Matt_Domsch@dell.com> wrote:

| For review and comment, three changesets against 2.6.0 at:
| 
| 	bk pull http://mdomsch.bkbits.net/linux-2.5-edd
| 
| This will update the following files:
| 
|  Documentation/i386/zero-page.txt |    4 -
|  arch/i386/boot/setup.S           |   21 ++++++
|  arch/i386/kernel/edd.c           |  128 ++++++++++++++++++++++++++++++++++-----
|  arch/i386/kernel/i386_ksyms.c    |    6 -
|  arch/i386/kernel/setup.c         |    7 ++
|  include/asm-i386/edd.h           |    6 +
|  include/asm-i386/setup.h         |    1 
|  7 files changed, 149 insertions, 24 deletions
| 
...
| 
| 
| Patches will follow.  Feedback welcome.

Where is a diff/patch file available for review?

Thanks,
--
~Randy
MOTD:  Always include version info.
