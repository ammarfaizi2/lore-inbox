Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269057AbTBXBnO>; Sun, 23 Feb 2003 20:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269058AbTBXBnO>; Sun, 23 Feb 2003 20:43:14 -0500
Received: from twinlark.arctic.org ([208.44.199.239]:6610 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S269057AbTBXBnO>; Sun, 23 Feb 2003 20:43:14 -0500
Date: Sun, 23 Feb 2003 17:53:25 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Kenneth Johansson <ken@kenjo.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <1046050010.2840.14.camel@tiger>
Message-ID: <Pine.LNX.4.53.0302231731260.23231@twinlark.arctic.org>
References: <E18moa2-0005cP-00@w-gerrit2>  <Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com>
  <20030223082036.GI10411@holomorphy.com>  <b3b6oa$bsj$1@penguin.transmeta.com>
  <1046031687.2140.32.camel@bip.localdomain.fake>  <16920000.1046033458@[10.10.2.4]>
  <1046044629.2210.3.camel@irongate.swansea.linux.org.uk> <1046050010.2840.14.camel@tiger>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Feb 2003, Kenneth Johansson wrote:

> If you really do mean compressed cache I don't think anybody has done
> that for real.

people are doing this *for real* -- it really depends on what you define
as compressed.

ARM thumb is definitely a compression function for code.

x86 native instructions are compressed compared to the RISC-like micro-ops
which a processor like athlon, p3, and p4 actually execute.  for similar
operations, an x86 would average probably 1.5 bytes to encode what a
32-bit RISC would need 4 bytes to encode.

-dean
