Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSHTWJx>; Tue, 20 Aug 2002 18:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317434AbSHTWJw>; Tue, 20 Aug 2002 18:09:52 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:33754 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317427AbSHTWJu>;
	Tue, 20 Aug 2002 18:09:50 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15714.48930.918372.268605@napali.hpl.hp.com>
Date: Tue, 20 Aug 2002 15:13:54 -0700
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: PCI Cleanup
In-Reply-To: <68750000.1029881681@w-hlinder>
References: <36220000.1029866315@w-hlinder>
	<15714.33709.181011.773290@napali.hpl.hp.com>
	<39680000.1029868258@w-hlinder>
	<15714.36383.143413.598935@napali.hpl.hp.com>
	<68750000.1029881681@w-hlinder>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hanna> Should there have been another patch that would go before the
  Hanna> 2.5.30 test patch on top of a kernel.org clean 2.5.30 kernel?
  Hanna> It is not applying cleanly and before I dig into code Im not
  Hanna> very familiar with I thought I would ask here. Yes, this is
  Hanna> my first time on an ia64 system.

The patch should be self-contained.  Can you check whether your mailer
perhaps auto-wrapped long lines?

	--david
