Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbTECV7L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 17:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTECV7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 17:59:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44560 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263440AbTECV7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 17:59:09 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: LSE conference call
Date: 3 May 2003 15:11:17 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b91eq5$j2s$1@cesium.transmeta.com>
References: <200304251826.h3PIQMNg001890@81-2-122-30.bradfords.org.uk> <3EB28FC2.6070305@coyotegulch.com> <m1ade4cdxl.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m1ade4cdxl.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
>
> Scott Robert Ladd <coyote@coyotegulch.com> writes:
> 
> > John Bradford wrote:
> > > Ah, but assuming that you had a compass to calculate the local time
> > > offset, (ignoring DST), anyway, you could have used that to calculate
> > > the _local_ time without looking at your watch at all ;-).  However,
> > > you wouldn't be able to calculate the timezone you were in.
> > 
> > Ah, but if you had a GPS system available, and a database of time zone
> > boundaries, you could adjust on-the-fly for different jurisdictions. I've dones
> > somethign of the sort recently for a client; the main problem lies in the
> > accuracy (and size) of the database. Indiana, for example, presents unique
> > challenges, with its patchwork implementation of DST...
> 
> Indiana doesn't do DST.  But it is true that people on the edges of the state
> like to know what time it is for their neighbors across the border.  
> 

Part of Indiana does DST, part of it doesn't.  In particular, the
parts of Indiana is in the CT timezone (Gary area) *does* do DST.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
