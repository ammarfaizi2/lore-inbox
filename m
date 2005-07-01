Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263194AbVGAHTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263194AbVGAHTs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbVGAHTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:19:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42931 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263194AbVGAHTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:19:44 -0400
Date: Fri, 1 Jul 2005 09:18:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050701071850.GA18926@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de> <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu> <200507010027.33079.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507010027.33079.annabellesgarden@yahoo.de>
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


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Ooops, you didn't apply this part of the patch:

oops - i had it in my tree (so all my tests passed), but it escaped the 
-39 patch. I've uploaded -50-40 with this included too.

	Ingo
