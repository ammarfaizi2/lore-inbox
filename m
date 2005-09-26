Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVIZGXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVIZGXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 02:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVIZGXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 02:23:00 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:4843 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932403AbVIZGW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 02:22:59 -0400
Date: Mon, 26 Sep 2005 08:23:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: Add headers to timeofday.c
Message-ID: <20050926062349.GB3273@elte.hu>
References: <1127345909.19506.49.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127345909.19506.49.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> Add cache.h for smp alignment, and seqlock.h for ntp_lock seqlock
> define.

thanks, applied.

	Ingo
