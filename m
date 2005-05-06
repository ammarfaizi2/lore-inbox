Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVEFXkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVEFXkf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVEFX14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:27:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:41684 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261326AbVEFXRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:17:50 -0400
Date: Fri, 6 May 2005 16:18:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: davej@redhat.com, torvalds@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050506161804.3ee419aa.akpm@osdl.org>
In-Reply-To: <20050506235842.A23651@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<20050302230634.A29815@flint.arm.linux.org.uk>
	<42265023.20804@pobox.com>
	<Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	<20050303002733.GH10124@redhat.com>
	<20050302203812.092f80a0.akpm@osdl.org>
	<20050304105247.B3932@flint.arm.linux.org.uk>
	<20050304032632.0a729d11.akpm@osdl.org>
	<20050304113626.E3932@flint.arm.linux.org.uk>
	<20050506235842.A23651@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> > So "rd_size" got deleted in -mm kernels without reference to anyone else
> > who's using it.  Greeeeaaatttt....
> 
> And guess what?  This patch is now in Linus kernel. Greeeeaaaattttt
> stuff whoever did that.  Truely wonderful job.

megamolehill, Russell.

> Thanks for taking notice of me a month ago.

I immediately dropped that patch when the problem was pointed out.

But early this month Adrian resent the same patch and I applied it again
and it slipped through.

> I really appreciate it.
> Especially when stuff gets merged which has already been pointed out
> as needlessly _BREAKING_ stuff.

Stuff happens.  That's why we have -rc kernels.

I already have the fix for this queued up.
