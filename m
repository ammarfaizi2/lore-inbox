Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbTENUtN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbTENUtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:49:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57352 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262793AbTENUtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:49:11 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Mount Rainier and kernel 2.6
Date: 14 May 2003 14:01:26 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b9uar6$18l$1@cesium.transmeta.com>
References: <20030514063216.2018C6EE92@rekin4.o2.pl> <20030514074626.GA17033@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030514074626.GA17033@suse.de>
By author:    Jens Axboe <axboe@suse.de>
In newsgroup: linux.dev.kernel
>
> On Wed, May 14 2003, fab@tlen.pl wrote:
> > I would like to ask if support for Mount Rainier is inluded in 2.6 
> > kernel (as it was written in artice info on page 
> > http://kt.zork.net/kernel-traffic/kt20021021_189.html#3)
> 
> No it isn't, at least not yet. As it just happens, my mt rainier drive
> is mounted in the 2.5 testbox though. If I get the time, I don't see any
> reason it can't make it into 2.6. It's a pretty simple addition now,
> ide-cd has write support etc.
> 

Are there any patches anywhere, or is it a case of SMP (Simple Matter
of Programming)?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
