Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVCHEXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVCHEXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 23:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVCHEXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 23:23:09 -0500
Received: from mx1.elte.hu ([157.181.1.137]:700 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261316AbVCHEXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 23:23:06 -0500
Date: Tue, 8 Mar 2005 05:22:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, paul@linuxaudiosystems.com,
       mpm@selenic.com, joq@io.com, cfriesen@nortelnetworks.com,
       chrisw@osdl.org, rlrevell@joe-job.com, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308042242.GA15356@elte.hu>
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308035503.GA31704@infradead.org> <20050307201646.512a2471.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307201646.512a2471.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> > next we
> > $CAPABILITY for $FOO and we're headed straight to interface-hell.
> 
> "interface hell"?  Wow.
> 
> Still.  It seems to be what we deserve if all that fancy stuff we have
> cannot address this very simple and very real-world problem.

please describe this "very simple and very real-world problem" in simple
terms. Lets make sure "problem" and "solution" didnt become detached.

	Ingo
