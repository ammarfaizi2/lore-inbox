Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319368AbSIGFXt>; Sat, 7 Sep 2002 01:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319441AbSIGFXt>; Sat, 7 Sep 2002 01:23:49 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:15024 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S319368AbSIGFXt>;
	Sat, 7 Sep 2002 01:23:49 -0400
Message-ID: <1031376503.3d798e7722432@kolivas.net>
Date: Sat,  7 Sep 2002 15:28:23 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: Batch scheduling and fixes added to performance patches (-ck)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated the merged patches:

O(1) - now includes batch scheduling
Preemptible
Low Latency - now fully supported on SMP
AA memory mods

and some other minor fixes.

Get them here as -ck6 :

http://kernel.kolivas.net

Feel free to give me your thoughts, comments, suggestions and don't forget to cc
me to ensure I see your email.

Cheers,
Con.
