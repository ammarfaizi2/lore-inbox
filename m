Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272413AbRI0LtN>; Thu, 27 Sep 2001 07:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272415AbRI0LtD>; Thu, 27 Sep 2001 07:49:03 -0400
Received: from ns.caldera.de ([212.34.180.1]:65434 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S272413AbRI0Ls7>;
	Thu, 27 Sep 2001 07:48:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15283.4638.235617.873920@ns.caldera.de>
Date: Thu, 27 Sep 2001 13:48:46 +0200 (CEST)
To: Ben Greear <greearb@candelatech.com>
Cc: Steven Rostedt <srostedt@stny.rr.com>,
        Torsten.Duwe@informatik.uni-erlangen.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mc146818rtc.h for user land programs (2.4.10)
In-Reply-To: <3BB2036D.A72C1C25@candelatech.com>
In-Reply-To: <Pine.LNX.4.33.0109261152100.5923-100000@localhost.localdomain>
	<3BB2036D.A72C1C25@candelatech.com>
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
From: Torsten Duwe <duwe@caldera.de>
Reply-to: Torsten.Duwe@caldera.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Ben> I can see arguing with Alan about the inclusion of linux-kernel
    Ben> headers in some cases, but I don't see anything in this file that
    Ben> looks like a user-space program could use.  Which part of this file
    Ben> do the user space programs need?

Don't want to add more spam; but since I was addressed personally I just
want to state that I agree with Ben here, as well as Tim's answer about the
fine nvram and rtc drivers.

	Torsten
