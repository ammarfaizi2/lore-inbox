Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268107AbUJHHAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268107AbUJHHAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 03:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUJHHAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 03:00:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24785 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268108AbUJHG66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 02:58:58 -0400
Date: Fri, 8 Oct 2004 09:00:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: 2.6.9-rc3-mm3
Message-ID: <20041008070028.GA30706@elte.hu>
References: <20041007015139.6f5b833b.akpm@osdl.org> <200410071041.20723.sandersn@btinternet.com> <20041007025007.77ec1a44.akpm@osdl.org> <20041007114040.GV9106@holomorphy.com> <1097184341l.10532l.0l@werewolf.able.es> <1097185597l.10532l.1l@werewolf.able.es> <20041007150708.5d60e1c3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007150708.5d60e1c3.akpm@osdl.org>
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

> > There is a problem with this -mm:
> 
> Yes, there seems to be a mingo/wli bunfight over prof_cpu_mask.

yeah.

> Something like this, I think:

great, another 40 lines gone from the generic irq code :)

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
