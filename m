Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbTFMHD7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 03:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbTFMHD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 03:03:59 -0400
Received: from palrel11.hp.com ([156.153.255.246]:33984 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S265212AbTFMHD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 03:03:56 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16105.31381.689569.8883@napali.hpl.hp.com>
Date: Fri, 13 Jun 2003 00:17:41 -0700
To: Roland McGrath <roland@redhat.com>
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: FIXMAP-related change to mm/memory.c
In-Reply-To: <200306130656.h5D6uGc32359@magilla.sf.frob.com>
References: <16105.28970.526326.249287@napali.hpl.hp.com>
	<200306130656.h5D6uGc32359@magilla.sf.frob.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 12 Jun 2003 23:56:16 -0700, Roland McGrath <roland@redhat.com> said:

  >> Could you test Linus' proposal?  It would definitely do the trick
  >> for ia64.

  Roland> This patch vs 2.5.70 works fine for me on x86.
  Roland> include/asm-x86_64/fixmap.h needs the macros added for its
  Roland> vsyscall page too.

I updated the ia64 tree accordingly.

Thanks!

	--david
