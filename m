Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbULQUNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbULQUNm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 15:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbULQUNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 15:13:42 -0500
Received: from hera.kernel.org ([209.128.68.125]:65215 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262148AbULQUMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 15:12:44 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: dynamic-hz
Date: Fri, 17 Dec 2004 20:12:04 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cpveik$s20$1@terminus.zytor.com>
References: <20041211142317.GF16322@dualathlon.random> <1103133841.3180.1.camel@localhost.localdomain> <Pine.LNX.4.61.0412151448580.4365@chaos.analogic.com> <200412152117.20568.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1103314324 28737 127.0.0.1 (17 Dec 2004 20:12:04 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 17 Dec 2004 20:12:04 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200412152117.20568.gene.heskett@verizon.net>
By author:    Gene Heskett <gene.heskett@verizon.net>
In newsgroup: linux.dev.kernel
> 
> Me sticks hand up and waves at teacher.
> 
> And what does 'Transconductance' have to do with this?
> 
> That may be the wrong terminology to apply here.
> 
> In vacuum tube (remember those?) specifications, this is the gain of
> the tube, which AIR is stated as the change in plate current for a
> one volt change in grid bias, and is normally stated in micromho's as
> they are high voltage, low current devices, with the highest gain
> tube that I'm aware of being the 7788.   Using the same measurement
> technique applied to modern relatively highed power field effect
> transistors where the currents can be many amperes, readings best
> stated in mho's are fairly common today. A 'mho' of course, is the
> reciprocal of an ohm.
> 
> >FYI, mS means milli-Siemens. Seconds is lower-case --always.
> 

To be excrutiatingly picky:

mS means millisiemens.  Siemens is the SI unit for
(trans)conductance.  Like all units named after people:

- its symbol (S) is capitalized;
- its name (siemens) is not (unless starting a sentence).

Note that since it's named after a person named Ernsr Werner von
Siemens, it's called "siemens" even in singular (1 S = 1 siemens).
According to normal English nomenclature then the plural would be
siemenses, but that doesn't seem to have caught on.

ms means milliseconds.  Seconds is the SI unit for time.  Like all
units not named after people:

- neither its symbol (s) nor its name (second) is capitalized.

	-hpa
