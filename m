Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSGSQzC>; Fri, 19 Jul 2002 12:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSGSQzC>; Fri, 19 Jul 2002 12:55:02 -0400
Received: from mx2.elte.hu ([157.181.151.9]:677 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316896AbSGSQzC>;
	Fri, 19 Jul 2002 12:55:02 -0400
Date: Sat, 20 Jul 2002 18:57:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH]: scheduler complex macros fixes
In-Reply-To: <200207191655.07285.efocht@ess.nec.de>
Message-ID: <Pine.LNX.4.44.0207201855380.17169-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Jul 2002, Erich Focht wrote:

> The attached patch fixes problems with the "complex" macros in the
> scheduler, as discussed about a week ago with Ingo on this mailing list.

the fix has been in my tree for some time, the latest version, against
2.5.26 is at:

  http://people.redhat.com/mingo/O(1)-scheduler/sched-2.5.26-B7

it has a number of other fixes as well, plus the SCHED_BATCH feature.

	Ingo

