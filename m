Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVAWEuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVAWEuR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVAWEuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:50:17 -0500
Received: from mail.joq.us ([67.65.12.105]:62426 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261222AbVAWEtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:49:25 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <200501230141.j0N1fOAB022422@localhost.localdomain>
	<41F3046A.1050808@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Sat, 22 Jan 2005 22:50:55 -0600
In-Reply-To: <41F3046A.1050808@kolivas.org> (Con Kolivas's message of "Sun,
 23 Jan 2005 12:56:58 +1100")
Message-ID: <87wtu421g0.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Meanwhile, I have the priority support working (but not bug free), and
> the preliminary results suggest that the results are better. Do I
> recall someone mentioning jackd uses threads at different priority?

Yes, it does.  

I'm not sure whether that matters in this test (it might).  

But, I'm certain it matters for some JACK applications.
-- 
  joq
