Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAIDVv>; Mon, 8 Jan 2001 22:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAIDVl>; Mon, 8 Jan 2001 22:21:41 -0500
Received: from nat-50.kulnet.kuleuven.ac.be ([134.58.0.50]:1367 "EHLO
	bakvis.kotnet.org") by vger.kernel.org with ESMTP
	id <S129226AbRAIDV2>; Mon, 8 Jan 2001 22:21:28 -0500
Date: Tue, 9 Jan 2001 04:23:29 +0100 (CET)
From: Frank Dekervel <kervel@bakvis.kotnet.org>
To: linux-kernel@vger.kernel.org
Subject: netfilter ipv6 as module unresolved symbols
Message-ID: <Pine.LNX.4.21.0101090421410.17358-100000@bakvis.kotnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

test13-acXX and final-acXX have unresolved symbols, namely
ipt_register_target and ipt_unregister_target in the module
ip6t_MARK.o

Greetings,

Kervel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
