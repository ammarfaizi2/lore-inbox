Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVAXEwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVAXEwJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 23:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVAXEwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 23:52:08 -0500
Received: from mail.joq.us ([67.65.12.105]:31152 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261439AbVAXEwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 23:52:05 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	<87pszvlvma.fsf@sulphur.joq.us> <41F42BD2.4000709@kolivas.org>
	<877jm3ljo9.fsf@sulphur.joq.us> <41F44AC2.1080609@kolivas.org>
	<87hdl7v3ik.fsf@sulphur.joq.us>
From: "Jack O'Quin" <joq@io.com>
Date: Sun, 23 Jan 2005 22:53:41 -0600
In-Reply-To: <87hdl7v3ik.fsf@sulphur.joq.us> (Jack O'Quin's message of "Sun,
 23 Jan 2005 22:45:39 -0600")
Message-ID: <87651nv356.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jack O'Quin <joq@io.com> writes:
> These results are indistinguishable from SCHED_FIFO...

Disregard my previous message, it was an idiotic mistake.  The results
were indistinguishable form SCHED_FIFO because they *were* SCHED_FIFO.
I'm running everything again, this time with the correct scheduling
parameters.  

Will post the correct numbers shortly.  Sorry for the screw-up.
-- 
  joq
