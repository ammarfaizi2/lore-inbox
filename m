Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269298AbUJQUbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269298AbUJQUbz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269290AbUJQUaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:30:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9428 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269289AbUJQU3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:29:45 -0400
Date: Sun, 17 Oct 2004 22:30:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] exec-shield-nx-2.6.9-A1
Message-ID: <20041017203055.GA10403@elte.hu>
References: <1098043886.2674.14320.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098043886.2674.14320.camel@cube>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Albert Cahalan <albert@users.sf.net> wrote:

> You have some bits in this patch that don't belong.
> They aren't even conditional on a config option or
> sysctl value.

maybe you misunderstood my mail. This was an announcement for
exec-shield users. You can safely ignore it.

> [...] One might guess from CAP_SYS_NICE that the feature has now
> become hopelessly slow. [...]

(thank you for the kind words, it is always heartening to read your
mails! I too wish you good luck with your projects.)

	Ingo
