Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318286AbSIKCTD>; Tue, 10 Sep 2002 22:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318288AbSIKCTD>; Tue, 10 Sep 2002 22:19:03 -0400
Received: from sabre.velocet.net ([216.138.209.205]:23562 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S318287AbSIKCTC>;
	Tue, 10 Sep 2002 22:19:02 -0400
To: linux-kernel@vger.kernel.org
Subject: eth2: failed to reset hardware (err = -16)
From: Gregory Stark <gsstark@mit.edu>
Date: 10 Sep 2002 22:23:47 -0400
Message-ID: <87u1kxb6x8.fsf@stark.dyndns.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I insert my USR 802.11b card it doesn't work and I get these messages.
What does "failed to reset hardware" mean is wrong?


Sep 10 22:20:21 stark kernel: hermes.c: 5 Apr 2002 David Gibson <hermes@gibson.dropbear.id.au>
Sep 10 22:20:21 stark kernel: orinoco.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)
Sep 10 22:20:21 stark kernel: orinoco_cs.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)
Sep 10 22:20:22 stark kernel: eth2: failed to reset hardware (err = -16)
Sep 10 22:20:22 stark kernel: orinoco_cs: register_netdev() failed



-- 
greg

