Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318194AbSIBBFz>; Sun, 1 Sep 2002 21:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318196AbSIBBFy>; Sun, 1 Sep 2002 21:05:54 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:40380 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S318194AbSIBBFy>;
	Sun, 1 Sep 2002 21:05:54 -0400
Message-ID: <1030929021.3d72ba7dadbe7@kolivas.net>
Date: Mon,  2 Sep 2002 11:10:21 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: Benchmarks for performance patches (-ck) for 2.4.19
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My merged patchset (http://kernel.kolivas.net) was designed to improve system
responsiveness. I have yet to find a good benchmark that measures such a thing.
However, in response to criticism about not providing benchmarks I have made
available some standard benchmarks at the excellent resources of the open source
development laboratory scalable test platform. They are available here:

http://www.osdl.org/stp

my patchsets are the following:
-ck5 patch is patch #781
-ck5-rmap is #782
-ck5-ll is #783

I have conducted some basic tests on #781 and the numbers show it is at least
equivalent to stock 2.4.19 (#747), although as I said none of these benchmarks
are designed to test desktop system responsiveness.

Please feel free to conduct any tests you like on these patches. I would be
interested to hear if anyone can suggest the most suitable benchmark. Please cc
me to ensure I receive any comments.

Con Kolivas
