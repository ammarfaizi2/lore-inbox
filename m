Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318066AbSHDCWR>; Sat, 3 Aug 2002 22:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318067AbSHDCWR>; Sat, 3 Aug 2002 22:22:17 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:57286 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318066AbSHDCWR>;
	Sat, 3 Aug 2002 22:22:17 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15692.37018.693984.745251@napali.hpl.hp.com>
Date: Sat, 3 Aug 2002 19:25:30 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: frankeh@watson.ibm.com, davidm@hpl.hp.com, davidm@napali.hpl.hp.com,
       torvalds@transmeta.com, gh@us.ibm.com, Martin.Bligh@us.ibm.com,
       wli@holomorpy.com, linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <20020803.173530.35650310.davem@redhat.com>
References: <Pine.LNX.4.44.0208031240270.9758-100000@home.transmeta.com>
	<15692.18584.1391.30730@napali.hpl.hp.com>
	<200208031754.30337.frankeh@watson.ibm.com>
	<20020803.173530.35650310.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 03 Aug 2002 17:35:30 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  DaveM>    From: Hubertus Franke <frankeh@watson.ibm.com> Date: Sat,
  DaveM> 3 Aug 2002 17:54:30 -0400

  DaveM>    The Rice paper solved this reasonably elegant. Reservation
  DaveM> and check after a while. If you didn't use reserved memory,
  DaveM> you loose it, this is the auto promotion/demotion.

  DaveM> I keep seeing this Rice stuff being mentioned over and over,
  DaveM> can someone post a URL pointer to this work?

Sure thing.  It's the first link under "Publications" at this URL:

	http://www.cs.rice.edu/~jnavarro/

  --david
