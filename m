Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262179AbRENQC7>; Mon, 14 May 2001 12:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbRENQCu>; Mon, 14 May 2001 12:02:50 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:26377 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262179AbRENQCl>; Mon, 14 May 2001 12:02:41 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Minor numbers
Date: 14 May 2001 09:02:36 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9dovis$epg$1@cesium.transmeta.com>
In-Reply-To: <200105141302.PAA14005@cave.bitwizard.nl> <E14zJmj-0000p3-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E14zJmj-0000p3-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > > 20:12 is more common
> > 
> > Which is major, which is minor?
> 
> 20bit major
> 

Surely you're jesting?

12 bit major, 20 bit minor is the only logical split.  The need for
minors (think individual disks) is much greater than the need for
majors.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
