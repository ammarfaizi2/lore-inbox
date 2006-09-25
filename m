Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWIYUG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWIYUG0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWIYUG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:06:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16031 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750816AbWIYUGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:06:25 -0400
Subject: Re: [git patch] libata fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060925193511.GA6129@havoc.gtf.org>
References: <20060925193511.GA6129@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 21:30:57 +0100
Message-Id: <1159216257.11049.137.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-25 am 15:35 -0400, ysgrifennodd Jeff Garzik:
> [hey Linus, your git summary hint helped, thanks]
> 
> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

Btw this one doesn't actually solve the FRV case. That's going to need
some more work and thinking. Look for patches tomorrow.

Alan

