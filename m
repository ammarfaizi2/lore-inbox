Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285355AbRLFWfO>; Thu, 6 Dec 2001 17:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285339AbRLFWe6>; Thu, 6 Dec 2001 17:34:58 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:56989 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S285272AbRLFWeO>;
	Thu, 6 Dec 2001 17:34:14 -0500
Date: Thu, 6 Dec 2001 17:34:13 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: <linux-kernel@vger.kernel.org>
Subject: Stupid PCI Bit-naming convention question
Message-ID: <Pine.LNX.4.30.0112061732040.22686-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In my attempts to investigate whether or not my m/b is afflicted by the
VIA KT266 hardware bug at device 1106:3099 register 0x95, bits 5,6,7, I
have a dumb question:  Namely, how are bits numbered?

I would assume that bits are numbered from smallest value to largest,
indexed at 0, so that bit 7 is the '128' component of a byte and bit 0 is
the '1' component.. correct?



