Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131416AbRAFADM>; Fri, 5 Jan 2001 19:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130664AbRAFADD>; Fri, 5 Jan 2001 19:03:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:4233 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129777AbRAFACy>;
	Fri, 5 Jan 2001 19:02:54 -0500
Date: Fri, 5 Jan 2001 15:44:36 -0800
Message-Id: <200101052344.PAA07261@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: vonbrand@inf.utfsm.cl
CC: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
In-Reply-To: <200101051721.f05HLaP21812@pincoya.inf.utfsm.cl> (message from
	Horst von Brand on Fri, 05 Jan 2001 14:21:35 -0300)
Subject: Re: 2.4.0 on sparc64 build problems
In-Reply-To: <200101051721.f05HLaP21812@pincoya.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The sparc64 config should never allow you to build the amd7930 and
dbri sbus sound drivers, that is a bug, and I'll fix that.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
