Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280771AbRKYJLX>; Sun, 25 Nov 2001 04:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280774AbRKYJLO>; Sun, 25 Nov 2001 04:11:14 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:12299
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S280771AbRKYJK7>; Sun, 25 Nov 2001 04:10:59 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200111250847.fAP8lVA27419@www.hockin.org>
Subject: Re: eepro100 Driver Problems ( wait
To: sidcarter@symonds.net
Date: Sun, 25 Nov 2001 00:47:31 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87zo5bgsk6.fsf@toboggan.in.ibm.com> from "Sid Carter" at Nov 25, 2001 02:01:37 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nov 25 13:43:58 toboggan kernel: eepro100: wait_for_cmd_done timeout!
> Nov 25 13:44:13 toboggan last message repeated 5 times


We have a patch for eepro100.c that should fix up a lot of issues - I need
to clean it up and solicit testers this week.

