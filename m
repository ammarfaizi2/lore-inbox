Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSHTSks>; Tue, 20 Aug 2002 14:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSHTSks>; Tue, 20 Aug 2002 14:40:48 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:24013 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317251AbSHTSkr>;
	Tue, 20 Aug 2002 14:40:47 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15714.36383.143413.598935@napali.hpl.hp.com>
Date: Tue, 20 Aug 2002 11:44:47 -0700
To: Hanna Linder <hannal@us.ibm.com>
Cc: davidm@hpl.hp.com, gregkh@us.ibm.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: PCI Cleanup
In-Reply-To: <39680000.1029868258@w-hlinder>
References: <36220000.1029866315@w-hlinder>
	<15714.33709.181011.773290@napali.hpl.hp.com>
	<39680000.1029868258@w-hlinder>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 20 Aug 2002 11:30:58 -0700, Hanna Linder <hannal@us.ibm.com> said:

  Hanna> Thanks for your quick reply. I found your 2.5.30 test patch
  Hanna> and I will give it a try on a system here. They are all MP
  Hanna> but I will configure it as UP.

Just a caveat: don't use the CMD649 IDE driver.  It seems to like to
eat your filesystem.  Other than that, I haven't had any problems.

	--david
