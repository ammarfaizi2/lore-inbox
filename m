Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272439AbTGZJsR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 05:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272445AbTGZJsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 05:48:17 -0400
Received: from 43.Red-80-34-245.pooles.rima-tde.net ([80.34.245.43]:62922 "EHLO
	mail.sambara.org") by vger.kernel.org with ESMTP id S272439AbTGZJsQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 05:48:16 -0400
Message-ID: <3F2251D3.3090107@sambara.org>
Date: Sat, 26 Jul 2003 12:02:59 +0200
From: Ismael Valladolid Torres <ismael@sambara.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: es-es, es
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org, mingo@elte.hu
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307261142.43277.m.c.p@wolk-project.de>
In-Reply-To: <200307261142.43277.m.c.p@wolk-project.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen escribe el 26/07/03 11:46:
> XMMS does not skip, but hey, I don't care about XMMS skipping at all.

For those of us who'd like to use Linux as a serious musical production 
environment in the near future, it is important to have the choice of a 
system that does exactly that. This is, audio should not skip even on a 
heavily loaded system. We do not care much about graphical 
responsiveness. Think of something like Pro Tools LE running over Mac 
OS, with up to 32 audio tracks being mixed without the help of a DSP 
chip. Even when CPU usage gets higher than 80%, you don't get a single 
audio glitch.

Of course, for musical production, also the lowest latency achievable is 
a must.

This is only a humble opinion which I hope you find useful.

Regards, Ismael

