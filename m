Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287832AbSANQuO>; Mon, 14 Jan 2002 11:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287731AbSANQsG>; Mon, 14 Jan 2002 11:48:06 -0500
Received: from socp-b.scsnet.com ([146.126.51.51]:41387 "EHLO
	alxapex01.southernco.com") by vger.kernel.org with ESMTP
	id <S287720AbSANQqs>; Mon, 14 Jan 2002 11:46:48 -0500
Message-ID: <5464FB52BACDD511B3D2006008CF3AF739CDAB@gaxgpex23.southernco.com>
From: "Hron, Randall" <x2hron@southernco.com>
To: "'rml@tech9.net'" <rml@tech9.net>, "'akpm@zip.com.au'" <akpm@zip.com.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 10:46:39 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.33)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, there appears to be a difference in throughput 
and latency between 2.4.18pre3-low-latency and
 2.4.18pre3-preempt+lockbreak.

2.4.18pre3pelb = preempt+lockbreak
2.4.18pre3ll = low-latency

http://home.earthlink.net/~rwhron/kernel/k6-2-475.html
