Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTFXKAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 06:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTFXKAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 06:00:46 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:34065 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261797AbTFXKAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 06:00:39 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.72-mm3 O(1) interactivity enhancements
Date: Tue, 24 Jun 2003 12:14:21 +0200
User-Agent: KMail/1.5.2
References: <1056368505.746.4.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1056368505.746.4.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306241214.22090.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 June 2003 13:41, Felipe Alfaro Solana wrote:

Hi Felipe,

> I have just cooked up a patch which mixes Mike Galbraith's excellent
> monotonic clock O(1) scheduler changes with another patch I think that
> came from Ingo Molnar and some scheduler parameter tweaks. This patch is
> against 2.5.72-mm3, but applies cleanly on top of 2.5.73.
> For me, it gives impressive interactive behavior. With it applied, I can
> no longer make XMMS skips sound, moving windows on an X session is
> perfectly smooth, even when moving them fastly enough for a very long
> time.
I am using your patch ontop of 2.5.73-mm1. Only two words: perfectly great!

> Thanks for listening!
thanks for the effort and the patch!

ciao, Marc

