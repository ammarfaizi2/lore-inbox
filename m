Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbUK3JBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUK3JBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 04:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbUK3I7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 03:59:38 -0500
Received: from mx1.elte.hu ([157.181.1.137]:28362 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262028AbUK3I6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 03:58:35 -0500
Date: Tue, 30 Nov 2004 09:58:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Eran Mann <emann@mrv.com>
Cc: linux-kernel@vger.kernel.org, remi.colinet@wanadoo.fr
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
Message-ID: <20041130085827.GB19516@elte.hu>
References: <41AA2A43.4000507@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AA2A43.4000507@mrv.com>
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


* Eran Mann <emann@mrv.com> wrote:

> I'm guessing here, but with the following patch it at least compiles:

yeah, this is the correct patch, included in the -31-14 and later
patches.

	Ingo
