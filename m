Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVBUQIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVBUQIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 11:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbVBUQHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 11:07:41 -0500
Received: from mx1.elte.hu ([157.181.1.137]:16086 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262012AbVBUQHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 11:07:37 -0500
Date: Mon, 21 Feb 2005 17:07:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: updated list of unused kernel exports posted
Message-ID: <20050221160730.GA12525@elte.hu>
References: <1108847674.6304.158.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108847674.6304.158.camel@laptopd505.fenrus.org>
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


* Arjan van de Ven <arjan@infradead.org> wrote:

> +wait_for_completion_interruptible
> +wait_for_completion_interruptible_timeout
> +wait_for_completion_timeout

these are fresh infrastructure additions, for which patches are in
flight for post-2.6.11.

	Ingo
