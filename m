Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWBMOE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWBMOE5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWBMOE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:04:57 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:24467 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751763AbWBMOE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:04:56 -0500
Date: Mon, 13 Feb 2006 15:03:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] hrtimer: remove DEFINE_KTIME/ktime_to_clock_t
Message-ID: <20060213140313.GF12923@elte.hu>
References: <Pine.LNX.4.61.0602130211260.23847@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602130211260.23847@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> Now that it_real_value is gone, the last user of DEFINE_KTIME and 
> ktime_to_clock_t are also gone, so remove it before someone starts 
> using it again.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

yeah.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
