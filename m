Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUKXIwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUKXIwi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 03:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbUKXIwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 03:52:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14048 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261300AbUKXIwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 03:52:36 -0500
Date: Wed, 24 Nov 2004 10:55:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041124095507.GA27705@elte.hu>
References: <20041124080710.GA20755@elte.hu> <Pine.OSF.4.05.10411240932230.9066-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411240932230.9066-100000@da410.ifa.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> Sorry. Is it allowed to send the patch as an attachment instead? That
> is easier.

sure, that's perfectly fine to me - i'll apply any format that applies.

generally, upstream submission is much stricter, the rules can be found
at:

  http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

but for -RT the number of patches isnt that high - just send anything
that applies cleanly.

	Ingo
