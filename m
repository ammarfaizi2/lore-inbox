Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271007AbTGVSwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271008AbTGVSwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:52:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:58598 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271007AbTGVSwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:52:05 -0400
Date: Tue, 22 Jul 2003 12:04:35 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: asm (lidt) question
Message-Id: <20030722120435.0ba9ae14.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.55.0307221156180.1372@bigblue.dev.mcafeelabs.com>
References: <20030717152819.66cfdbaf.rddunlap@osdl.org>
	<Pine.LNX.4.55.0307171535020.4845@bigblue.dev.mcafeelabs.com>
	<Pine.LNX.4.55.0307171615580.4845@bigblue.dev.mcafeelabs.com>
	<20030722172722.GC3267@mail.jlokier.co.uk>
	<Pine.LNX.4.55.0307221021130.1372@bigblue.dev.mcafeelabs.com>
	<20030722115823.4b34f9ce.rddunlap@osdl.org>
	<Pine.LNX.4.55.0307221156180.1372@bigblue.dev.mcafeelabs.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jul 2003 11:58:16 -0700 (PDT) Davide Libenzi <davidel@xmailserver.org> wrote:

| > Yes, less confusion is better, so here's a patch to use the
| > same reasonable syntax in all places.
| >
| > Look OK?  Generates the same code, as Davide pointed out.
| 
| Yep, that's the right syntax (pls push to Andrew or Linus) ;)
| 

Yes, planning to.

~Randy
