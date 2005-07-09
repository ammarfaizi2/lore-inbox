Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVGISOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVGISOk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 14:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVGISOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 14:14:40 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:3750 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261636AbVGISOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 14:14:39 -0400
Subject: Re: linux-2.6.12-RT-V0.7.51-18: RT task yield()-ing!
From: Lee Revell <rlrevell@joe-job.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1120919366.14404.5.camel@twins>
References: <1120919366.14404.5.camel@twins>
Content-Type: text/plain
Date: Sat, 09 Jul 2005 14:14:37 -0400
Message-Id: <1120932877.6488.61.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-09 at 16:29 +0200, Peter Zijlstra wrote:
>  [<f09ce1a4>] emu10k1_audio_release+0x114/0x210 [emu10k1] (40)

Kind of OT, but any particular reason you're using this old OSS driver?
It's likely to be deprecated soon, and the ALSA driver is much more
actively maintained...

Lee

