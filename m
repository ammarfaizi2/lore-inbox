Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbSKFGhf>; Wed, 6 Nov 2002 01:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265766AbSKFGhf>; Wed, 6 Nov 2002 01:37:35 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:41988
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265683AbSKFGhe>; Wed, 6 Nov 2002 01:37:34 -0500
Subject: Re: [PATCH ] POSIX clocks & timers take 10 (NOT HIGH RES)
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: george anzinger <george@mvista.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3DC8B73E.FA82A6B5@mvista.com>
References: <3DC8B73E.FA82A6B5@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 01:44:20 -0500
Message-Id: <1036565060.782.448.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 01:31, george anzinger wrote:

> This, patch implements the POSIX clocks and timers
> functions.  The two standard clocks are
> defined(CLOCK_REALTIME & CLOCK_MONOTONIC). 

Linus, do you have any objections to not taking at least the core system
calls for the POSIX clocks and timers?

	Robert Love

