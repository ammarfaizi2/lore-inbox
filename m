Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVBFNFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVBFNFS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVBFNFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:05:17 -0500
Received: from canuck.infradead.org ([205.233.218.70]:58629 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261227AbVBFNFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:05:06 -0500
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, drepper@redhat.com
In-Reply-To: <20050206130152.GH30109@wotan.suse.de>
References: <20050206113635.GA30109@wotan.suse.de>
	 <20050206114758.GA8437@infradead.org> <20050206120244.GA28061@elte.hu>
	 <20050206124523.GA762@elte.hu> <20050206125002.GF30109@wotan.suse.de>
	 <1107694800.22680.90.camel@laptopd505.fenrus.org>
	 <20050206130152.GH30109@wotan.suse.de>
Content-Type: text/plain
Date: Sun, 06 Feb 2005 14:04:57 +0100
Message-Id: <1107695097.22680.92.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hmm, I got a report that it doesn't work anymore with 
> 2.6.11rcs on x86-64. I haven't looked  closely yet,
> but it wouldn't surprise me if this change isn't also involved.

PT_GNU_STACK change is there since like 2.6.6 (and was put in by a suse person)
To me that is a strong indication that you are wrong on your
suspicion...



