Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316955AbSFWBmF>; Sat, 22 Jun 2002 21:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSFWBmE>; Sat, 22 Jun 2002 21:42:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56593 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316955AbSFWBmD>; Sat, 22 Jun 2002 21:42:03 -0400
Subject: Re: RFC: per-socket statistics on received/dropped packets
To: ltd@cisco.com (Lincoln Dale)
Date: Sun, 23 Jun 2002 03:03:47 +0100 (BST)
Cc: vonbrand@inf.utfsm.cl (Horst von Brand),
       davem@redhat.com (David S. Miller),
       greearb@candelatech.com (Ben Greear), linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <5.1.0.14.2.20020612221925.0283fb18@mira-sjcm-3.cisco.com> from "Lincoln Dale" at Jun 12, 2002 10:28:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17LwjD-0003hT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i know of many many folk who use transaction logs from HTTP caches for 
> volume-based billing.
> right now, those bills are anywhere between 10% to 25% incorrect.
> 
> you call that "extremely limited"?

It wouldnt help you anyway. Prove which frames were not due to the
overloading and congestion/errors on your network which therefore the customer should 
not have a duty to pay. Account for bitstuffing on HDLC links...
