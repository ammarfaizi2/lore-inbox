Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131452AbRAFAdb>; Fri, 5 Jan 2001 19:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131326AbRAFAdW>; Fri, 5 Jan 2001 19:33:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18057 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129383AbRAFAdC>;
	Fri, 5 Jan 2001 19:33:02 -0500
Date: Fri, 5 Jan 2001 16:15:58 -0800
Message-Id: <200101060015.QAA07342@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: uzi@uzix.org
CC: vonbrand@inf.utfsm.cl, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
In-Reply-To: <20010105160021.A18483@gimp.org> (message from Joshua Uziel on
	Fri, 5 Jan 2001 16:00:21 -0800)
Subject: Re: 2.4.0 on sparc64 build problems
In-Reply-To: <200101051721.f05HLaP21812@pincoya.inf.utfsm.cl> <20010105160021.A18483@gimp.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Fri, 5 Jan 2001 16:00:21 -0800
   From: Joshua Uziel <uzi@uzix.org>

   Basically, those two should be removed from the config options for
   sparc64... and in the meantime, you should build without 'em. :)

Note that 2.2.x has this exact fix already, and that 2.2.x fix
came from a similar bug report from Horst von Brand :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
