Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVISIqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVISIqO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 04:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVISIqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 04:46:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56213 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932381AbVISIqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 04:46:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
X-Fcc: ~/Mail/linus
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, macro@linux-mips.org, akpm@osdl.org, dev@sw.ru,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] more sigkill priority fix
In-Reply-To: Heiko Carstens's message of  Monday, 19 September 2005 10:24:23 +0200 <20050919082423.GB15034@osiris.boeblingen.de.ibm.com>
X-Zippy-Says: ..  I wonder if I ought to tell them about my PREVIOUS LIFE as a
   COMPLETE STRANGER?
Message-Id: <20050919084607.0D50C180E1D@magilla.sf.frob.com>
Date: Mon, 19 Sep 2005 01:46:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this the way the kernel is supposed to handle signals now?
> Just wondering, since this changes signal handling quite significantly from
> what it was before.

It has always been the correct behavior.


Thanks,
Roland
