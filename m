Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275384AbRIZR7v>; Wed, 26 Sep 2001 13:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275391AbRIZR7l>; Wed, 26 Sep 2001 13:59:41 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:64529
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S275384AbRIZR7U>; Wed, 26 Sep 2001 13:59:20 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200109261740.f8QHe3C26922@www.hockin.org>
Subject: Re: [PATCH] mc146818rtc.h for user land programs (2.4.10)
To: greearb@candelatech.com (Ben Greear)
Date: Wed, 26 Sep 2001 10:40:03 -0700 (PDT)
Cc: srostedt@stny.rr.com (Steven Rostedt), duwe@informatik.uni-erlangen.de,
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3BB2036D.A72C1C25@candelatech.com> from "Ben Greear" at Sep 26, 2001 09:33:49 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in some cases, but I don't see anything in this file that looks like a
> user-space program could use.  Which part of this file do the user
> space programs need?

agreed - if you need to access CMOS use rtc and nvram drivers.

