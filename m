Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSHXG3F>; Sat, 24 Aug 2002 02:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSHXG3F>; Sat, 24 Aug 2002 02:29:05 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:25022 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S315388AbSHXG3E>;
	Sat, 24 Aug 2002 02:29:04 -0400
Message-ID: <1030170794.3d6728aa24046@kolivas.net>
Date: Sat, 24 Aug 2002 16:33:14 +1000
From: conman@kolivas.net
To: linux-kernel@vger.kernel.org
Subject: VM changes added to performance patches for 2.4.19
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With the patch against 2.4.19:

Scheduler O(1), Preemptible, Low Latency

I have now added two extra alternative patches that include 
either Rik's rmap (thanks Rik) or AA's vm changes (thanks to Nuno Monteiro for
merging this)

For the record, with the (very) brief usage of these two patches I found the
rmap patch a little faster. This is very subjective and completely untested.

Check them out here and tell me what you think(please read the FAQ):
http://kernel.kolivas.net

Con Kolivas
