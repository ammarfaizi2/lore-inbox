Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbTLHQI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbTLHQI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:08:29 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:48610 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S265490AbTLHQID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:08:03 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: Physical address
Date: Mon, 08 Dec 2003 17:05:50 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2003.12.08.16.05.47.407612@smurf.noris.de>
References: <20031208150713.39743.qmail@web25201.mail.ukl.yahoo.com> <Pine.LNX.4.53.0312081019410.29539@chaos>
NNTP-Posting-Host: p50847149.dip.t-dialin.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: play.smurf.noris.de 1070899549 2224 80.132.113.73 (8 Dec 2003 16:05:49 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Mon, 8 Dec 2003 16:05:49 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Richard B. Johnson wrote:

> Don't expect any help
> from some LK pedantics, but this hack will get you started if
> you are not using any special addresses (like high RAM).

... and if the driver will never run on non-PC-like or non-x86 systems.

> Also, don't tell anybody .... <grin>...

*Grumble*. IMHO you(generic) should do this right the first time.
The learning curve may be a bit steeper, but OTOH you won't get into any
bad habits, and you won't leave a mess for other people to debug.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
We are bits of stellar matter that got cold
by accident, bits of a star gone wrong.
		-- Sir Arthur Eddington

