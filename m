Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272445AbTGZJz2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 05:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272446AbTGZJz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 05:55:28 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:49281 "EHLO
	amaryllis.anomalistic.org") by vger.kernel.org with ESMTP
	id S272445AbTGZJz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 05:55:26 -0400
Date: Sat, 26 Jul 2003 18:10:15 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Ismael Valladolid Torres <ismael@sambara.org>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org, mingo@elte.hu
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Message-ID: <20030726101015.GA3922@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307261142.43277.m.c.p@wolk-project.de> <3F2251D3.3090107@sambara.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2251D3.3090107@sambara.org>
X-Operating-System: Linux 2.4.21-ck3
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What I really want to see is the best of both worlds if possible.
Well, some may be more keen to see responsiveness in work-related
tasks, there are others who wants more responsiveness in their
leisure-related work. I hope that Con do not stop developing his 
interactive improvements just because mingo is starting to work 
his too.

Eugene

<quote sender="Ismael Valladolid Torres">
> Marc-Christian Petersen escribe el 26/07/03 11:46:
> >XMMS does not skip, but hey, I don't care about XMMS skipping at all.
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
> 
> Regards, Ismael
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
