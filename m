Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVAZOVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVAZOVe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVAZOVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:21:34 -0500
Received: from mail.joq.us ([67.65.12.105]:25220 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262308AbVAZOVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:21:31 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU feature, -D7
References: <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	<20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
	<41F6C5CE.9050303@bigpond.net.au> <41F6C797.80403@bigpond.net.au>
	<20050126100846.GB8720@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 26 Jan 2005 08:22:08 -0600
In-Reply-To: <20050126100846.GB8720@elte.hu> (Ingo Molnar's message of "Wed,
 26 Jan 2005 11:08:46 +0100")
Message-ID: <87pszsnucv.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> (My current thinking is that the default RT_CPU rlimit should be 0.)

How about a kernel .config option allowing us to easily compile in a
different default?

That should tide over most of the audio users for the next 6 months or
so until we get userspace tools from the various distributions.
-- 
  joq
