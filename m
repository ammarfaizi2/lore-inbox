Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbULBA2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbULBA2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 19:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbULBA2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 19:28:19 -0500
Received: from cantor.suse.de ([195.135.220.2]:21148 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261525AbULBA0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 19:26:21 -0500
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jakub Jelinek <jakub@redhat.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: var args in kernel?
References: <Pine.LNX.3.96.1041201174645.26528F-100000@gatekeeper.tmr.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Clear the laundromat!!  This whirl-o-matic just had a nuclear
 meltdown!!
Date: Thu, 02 Dec 2004 01:26:18 +0100
In-Reply-To: <Pine.LNX.3.96.1041201174645.26528F-100000@gatekeeper.tmr.com> (Bill
 Davidsen's message of "Wed, 1 Dec 2004 17:49:29 -0500 (EST)")
Message-ID: <je1xe98s0l.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> Why did you think I said array?

We are talking about assignment of va_list here, which is an array on some
architectures. 

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
