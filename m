Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVBBWpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVBBWpU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbVBBWoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 17:44:39 -0500
Received: from mail.joq.us ([67.65.12.105]:4245 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262919AbVBBWoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 17:44:05 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us>
	<1106782165.5158.15.camel@npiggin-nld.site>
	<874qh3bo1u.fsf@sulphur.joq.us>
	<1106796360.5158.39.camel@npiggin-nld.site>
	<87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu>
	<873bwfo8br.fsf@sulphur.joq.us>
	<1107370770.3104.136.camel@krustophenia.net>
	<87pszikbcv.fsf@sulphur.joq.us> <20050202202953.GA9840@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 02 Feb 2005 16:45:18 -0600
In-Reply-To: <20050202202953.GA9840@elte.hu> (Ingo Molnar's message of "Wed,
 2 Feb 2005 21:29:53 +0100")
Message-ID: <87psziinsx.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> so forgive us this stubborness, it's not directed against you in person
> or against any group of users, it's always directed at the problem at
> hand. I think we can do the LSM thing, and if this problem comes up in
> the future again, then maybe by that time there will be a better
> solution. (e.g. it's quite possible that something nice will come out of
> the various virtualization projects, for this problem area.)

No hard feelings, Ingo.  

I respect stubbornness in the pursuit of quality.  

If requested, I will provide testing and other support for those
working on better solutions.
-- 
  joq
