Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262770AbSITPSE>; Fri, 20 Sep 2002 11:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262772AbSITPSE>; Fri, 20 Sep 2002 11:18:04 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:12168 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262770AbSITPSD>;
	Fri, 20 Sep 2002 11:18:03 -0400
Message-ID: <1032535387.3d8b3d5b4a8c2@kolivas.net>
Date: Sat, 21 Sep 2002 01:23:07 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: Cliff White <cliffw@osdl.org>
Subject: contest update to 0.35
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding the contest responsiveness benchmark (http://contest.kolivas.net)

I've made a minor update to 0.35. The main change is that it does one extra
kernel compile before each actual test. This pretty much washes away the effect
of previous loads that were running, and starts off every benchmark on the same
footing in terms of what is cached in ram.

Con.
