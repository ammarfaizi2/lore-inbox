Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268007AbTAKT2V>; Sat, 11 Jan 2003 14:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268116AbTAKT2V>; Sat, 11 Jan 2003 14:28:21 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:9432 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S268102AbTAKT2U>;
	Sat, 11 Jan 2003 14:28:20 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15904.29254.176062.449708@napali.hpl.hp.com>
Date: Sat, 11 Jan 2003 11:36:38 -0800
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Ulrich Drepper <drepper@redhat.com>,
       <davidm@hpl.hp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: make AT_SYSINFO platform-independent
In-Reply-To: <Pine.LNX.4.44.0301111128150.25432-100000@home.transmeta.com>
References: <20030111185744.A5009@infradead.org>
	<Pine.LNX.4.44.0301111128150.25432-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 11 Jan 2003 11:29:14 -0800 (PST), Linus Torvalds <torvalds@transmeta.com> said:

  Linus> Anyway, as I said in another mail, I think 18 is a bad
  Linus> choice, and I'll leave it at 32.

But you will move it into <linux/elf.h>?

	--david
