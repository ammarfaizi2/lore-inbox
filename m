Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318042AbSHDAqP>; Sat, 3 Aug 2002 20:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSHDAqP>; Sat, 3 Aug 2002 20:46:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30643 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318042AbSHDAqO>;
	Sat, 3 Aug 2002 20:46:14 -0400
Date: Sat, 03 Aug 2002 17:35:30 -0700 (PDT)
Message-Id: <20020803.173530.35650310.davem@redhat.com>
To: frankeh@watson.ibm.com
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, torvalds@transmeta.com,
       gh@us.ibm.com, Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200208031754.30337.frankeh@watson.ibm.com>
References: <Pine.LNX.4.44.0208031240270.9758-100000@home.transmeta.com>
	<15692.18584.1391.30730@napali.hpl.hp.com>
	<200208031754.30337.frankeh@watson.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hubertus Franke <frankeh@watson.ibm.com>
   Date: Sat, 3 Aug 2002 17:54:30 -0400
   
   The Rice paper solved this reasonably elegant. Reservation and check 
   after a while. If you didn't use reserved memory, you loose it, this is the 
   auto promotion/demotion.

I keep seeing this Rice stuff being mentioned over and over,
can someone post a URL pointer to this work?
