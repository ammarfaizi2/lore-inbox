Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285319AbRLFXwh>; Thu, 6 Dec 2001 18:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285321AbRLFXw1>; Thu, 6 Dec 2001 18:52:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27923 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285319AbRLFXwN>; Thu, 6 Dec 2001 18:52:13 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Stupid PCI Bit-naming convention question
Date: 6 Dec 2001 15:51:49 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9up0al$84m$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0112061732040.22686-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.30.0112061732040.22686-100000@rtlab.med.cornell.edu>
By author:    "Calin A. Culianu" <calin@ajvar.org>
In newsgroup: linux.dev.kernel
> 
> In my attempts to investigate whether or not my m/b is afflicted by the
> VIA KT266 hardware bug at device 1106:3099 register 0x95, bits 5,6,7, I
> have a dumb question:  Namely, how are bits numbered?
> 
> I would assume that bits are numbered from smallest value to largest,
> indexed at 0, so that bit 7 is the '128' component of a byte and bit 0 is
> the '1' component.. correct?
> 

Yes.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
