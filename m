Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWETRgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWETRgj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 13:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWETRgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 13:36:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10948 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751449AbWETRgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 13:36:38 -0400
Date: Sat, 20 May 2006 10:36:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] net driver updates
In-Reply-To: <20060520092033.7d404315.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0605201035510.10823@g5.osdl.org>
References: <20060520042856.GA7218@havoc.gtf.org> <20060520092033.7d404315.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 May 2006, Andrew Morton wrote:
> Jeff Garzik <jeff@garzik.org> wrote:
> >
> > Andrew Morton:
> >        revert "forcedeth: fix multi irq issues"
> 
> Manfred just found the fix for this, so we should no longer need to revert.

Hmm. I already pulled. I guess we can revert the revert and apply 
Manfreds fix. Jeff?

		Linus
