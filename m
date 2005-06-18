Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVFRM2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVFRM2w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 08:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVFRM2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 08:28:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:6610 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262104AbVFRM2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 08:28:50 -0400
Date: Sat, 18 Jun 2005 14:28:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@lysdexia.org>
Cc: William Weston <weston@sysex.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050618122805.GA32041@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org> <Pine.LNX.4.58.0506171419050.786@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506171419050.786@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@lysdexia.org> wrote:

> Running -48-36 on the Xeon/HT box, I lost keyboard and network after a 
> couple hours.  Same .config as was used for -48-33 (attached... forgot 
> to send in previous email).  Xscreensaver was still running with no 
> way to unlock the console.  Back to -48-33 for the time being.

does -48-37 work any better?

	Ingo
