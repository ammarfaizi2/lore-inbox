Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVAOAmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVAOAmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVAOAmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:42:50 -0500
Received: from mail.joq.us ([67.65.12.105]:29632 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262059AbVAOAmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:42:39 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: Matt Mackall <mpm@selenic.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wright <chrisw@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050110212019.GG2995@waste.org>
	<200501111305.j0BD58U2000483@localhost.localdomain>
	<20050111191701.GT2940@waste.org>
	<20050111125008.K10567@build.pdx.osdl.net>
	<20050111205809.GB21308@elte.hu>
	<20050111131400.L10567@build.pdx.osdl.net>
	<20050111212719.GA23477@elte.hu> <87fz15j325.fsf@sulphur.joq.us>
	<20050113063446.GV2940@waste.org> <87is61b0l4.fsf@sulphur.joq.us>
	<1105735965.7258.24.camel@krustophenia.net>
From: "Jack O'Quin" <joq@io.com>
Date: Fri, 14 Jan 2005 18:42:24 -0600
In-Reply-To: <1105735965.7258.24.camel@krustophenia.net> (Lee Revell's
 message of "Fri, 14 Jan 2005 15:52:44 -0500")
Message-ID: <87zmzb7cb3.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, 2005-01-13 at 13:17 -0600, Jack O'Quin wrote:
>> But there may be other, better solutions to the deadlock problem.
>> Several years ago, Roger Larsson wrote a completely user-space
>> realtime monitor program that works perfectly well for revoking
>> realtime privileges when it detects CPU starvation.  I still use it
>> occasionally to help debug problems if the built-in JACK watchdog
>> timer doesn't catch them.

Lee Revell <rlrevell@joe-job.com> writes:
> Do you have a link to Roger Larsson's RT watchdog?

No official, supported version.  With his permission, I posted a copy
on my home system a year ago for some audio users who had inquired
about it.  That copy is here...

  http://www.joq.us/joq/rt_monitor.tgz
-- 
  joq
