Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272496AbTGZOaF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272497AbTGZOaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:30:05 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:41353
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272496AbTGZO35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:29:57 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ismael Valladolid Torres <ismael@sambara.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Sun, 27 Jul 2003 00:49:03 +1000
User-Agent: KMail/1.5.2
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307261142.43277.m.c.p@wolk-project.de> <3F2251D3.3090107@sambara.org>
In-Reply-To: <3F2251D3.3090107@sambara.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307270049.03730.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jul 2003 20:02, Ismael Valladolid Torres wrote:
> Marc-Christian Petersen escribe el 26/07/03 11:46:
> > XMMS does not skip, but hey, I don't care about XMMS skipping at all.
>
> For those of us who'd like to use Linux as a serious musical production
> environment in the near future, it is important to have the choice of a
> system that does exactly that. This is, audio should not skip even on a
> heavily loaded system. We do not care much about graphical
> responsiveness. Think of something like Pro Tools LE running over Mac
> OS, with up to 32 audio tracks being mixed without the help of a DSP
> chip. Even when CPU usage gets higher than 80%, you don't get a single
> audio glitch.
>
> Of course, for musical production, also the lowest latency achievable is
> a must.
>
> This is only a humble opinion which I hope you find useful.

Everyone's opinion counts here as everyone uses the scheduler. As far as I'm 
concerned it should perform well in as many settings as possible.

Con

