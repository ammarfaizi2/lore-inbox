Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbUCKVqB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 16:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbUCKVqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 16:46:01 -0500
Received: from hell.org.pl ([212.244.218.42]:1286 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261763AbUCKVp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 16:45:58 -0500
Date: Thu, 11 Mar 2004 22:46:01 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PATCH: Shutdown IDE before powering off.
Message-ID: <20040311214601.GA3109@hell.org.pl>
References: <1gC8S-6UB-5@gated-at.bofh.it> <1gIHq-3JU-23@gated-at.bofh.it> <1gPzb-1OM-17@gated-at.bofh.it> <1gQET-2Qn-9@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1gQET-2Qn-9@gated-at.bofh.it>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Bartlomiej Zolnierkiewicz:
> 
> On Thursday 22 of January 2004 17:02, Jeff Garzik wrote:
> > I'm either shock or very very worried that the reboot notifier that
> > flushes IDE in 2.4.x, ide_notifier, is nowhere to be seen in 2.6.x :(
> > That seems like the real problem -- the code _used_ to be there.
> 
> Yep, it should be re-added.  I wonder when/why it was removed?

Hi,
What's the current status of this issue?
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
