Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVAYVMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVAYVMd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVAYVC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:02:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:35472 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262148AbVAYVBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:01:38 -0500
Date: Tue, 25 Jan 2005 22:01:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: wait_for_completion API extension addition
Message-ID: <20050125210102.GA6452@elte.hu>
References: <41F6AA83.20306@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F6AA83.20306@sun.com>
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


* Mike Waychison <Michael.Waychison@Sun.COM> wrote:

> Hi Ingo,
> 
> I noticed that the wait_for_completion API extensions made it into
> mainline.
> 
> However, I posted that the patch in question is broken a while back:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110131832828126&w=2
> 
> Can we fix this?

(/me pokes himself in the eyes)

could you send an incremental patch against BK-curr?

	Ingo
