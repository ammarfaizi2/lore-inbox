Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264414AbUD0Xqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbUD0Xqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbUD0Xqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:46:53 -0400
Received: from hell.org.pl ([212.244.218.42]:54289 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S264414AbUD0Xqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:46:47 -0400
Date: Wed, 28 Apr 2004 01:46:53 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Pavel Machek <pavel@ucw.cz>
Cc: 234976@bugs.debian.org, linux-kernel@vger.kernel.org
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040427234653.GA23804@hell.org.pl>
References: <1Pb4h-8hZ-11@gated-at.bofh.it> <1Pc0Y-BC-45@gated-at.bofh.it> <1PcWn-1tE-11@gated-at.bofh.it> <1Pf8I-3qP-31@gated-at.bofh.it> <1PuTf-7ZO-7@gated-at.bofh.it> <1Py1q-1ZH-23@gated-at.bofh.it> <1Py1y-1ZH-43@gated-at.bofh.it> <1PAlX-3Vx-1@gated-at.bofh.it> <20040427233009.GA24051@hell.org.pl> <20040427233341.GA6592@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20040427233341.GA6592@elf.ucw.cz>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Pavel Machek:
> > > This should be better solution, could anyone test it? [It compiles,
> > > and I'm out of time now].
> > It reboots my system while reading pageset.
> And it worked before?

Right, you didn't receive that. Yes, plain swsusp1 passes that stage but
hangs or reboots during copying (or a little bit after) and with Herbert 
Xu's patch I can suspend and resume with glxgears running.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
