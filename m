Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVGTUq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVGTUq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 16:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVGTUq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 16:46:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9122 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261500AbVGTUqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 16:46:08 -0400
Date: Wed, 20 Jul 2005 22:45:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stuart_Hayes@Dell.com
Cc: ak@suse.de, riel@redhat.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: page allocation/attributes question (i386/x86_64 specific)
Message-ID: <20050720204556.GB8665@elte.hu>
References: <B1939BC11A23AE47A0DBE89A37CB26B40743C7@ausx3mps305.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1939BC11A23AE47A0DBE89A37CB26B40743C7@ausx3mps305.aus.amer.dell.com>
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


* Stuart_Hayes@Dell.com <Stuart_Hayes@Dell.com> wrote:

> Oh, sorry, we're talking about two different patches.  I sent in a 
> different patch yesterday, because Andi Kleen didn't seem very 
> enthusiastic about fixnx2.patch.  Here's the patch that I sent 
> yesterday (attached as file init.c.patch).

ah - ok - this patch indeed should solve it.

	Ingo
