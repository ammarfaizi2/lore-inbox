Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267705AbUH0Uwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbUH0Uwk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267582AbUH0Urz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:47:55 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:50907 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267605AbUH0Uom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:44:42 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.9-rc1-mm1
Date: Fri, 27 Aug 2004 22:54:58 +0200
User-Agent: KMail/1.5
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200408270058.i7R0wDV04916@owlet.beaverton.ibm.com>
In-Reply-To: <200408270058.i7R0wDV04916@owlet.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408272254.58646.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 of August 2004 02:58, Rick Lindsley wrote:
>     Rick's schedstats stuff had some ways to measure latency that seemed to
> work quite nicely. Hard to simulate exactly mozilla, email, etc, but
> probably close enough to be far more use than "ooh, it feels faster".
>
>     He did a whole paper at OLS ... Rick ... pointer?
>
> http://www.finux.org/Reprints/Reprint-Lindsley-OLS2004.pdf
>
> There are patches available for schedstats, although I haven't pulled
> together 2.6.9-rc1 yet.  Shouldn't take me but fifteen minutes, I think.
>
> Rafael, what baseline release are you comparing to?  I should be able
> to provide some tools to measure the effect on updatedb directly for
> both 2.6.9-rc1 and your baseline (so long as it's 2.6-based)

2.6.8.1, for example.  I'd like to compate it with the 2.6.9-rc1-mm1, which 
contains the Nick's scheduler (2.6.9-rc1 has the same scheduler as 2.6.8.1, 
AFAIK).

Regards,
RJW

-- 
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
