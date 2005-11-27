Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbVK0O7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbVK0O7i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 09:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVK0O7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 09:59:38 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:27558 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751078AbVK0O7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 09:59:38 -0500
Date: Sun, 27 Nov 2005 15:59:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rt15 @x86_64UP: "sem_post: Invalid argument"
Message-ID: <20051127145947.GA28922@elte.hu>
References: <200511261140.47931.annabellesgarden@yahoo.de> <200511271517.18931.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511271517.18931.annabellesgarden@yahoo.de>
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


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Am Samstag, 26. November 2005 11:40 schrieb Karsten Wiese:
> > I get loads of those messages since switching from rt12 to rt15.
> 
> fixed in rt20.

great.

> I've got an "io_apic cached" patch for x86_64 here, that ticks since 
> weeks on my UP. Interesting?

yeah, please send it, i'll add it to -rt.

	Ingo
