Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSINX2Y>; Sat, 14 Sep 2002 19:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317623AbSINX2Y>; Sat, 14 Sep 2002 19:28:24 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:37805 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S317622AbSINX2X>;
	Sat, 14 Sep 2002 19:28:23 -0400
Message-ID: <1032046397.3d83c73d5b732@kolivas.net>
Date: Sun, 15 Sep 2002 09:33:17 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: devfs on 2.5.34 and invisible partition
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



My /dev/hda7 (ide/host0/bus0/target0/lun0/part7) was rendered invisible with
devfs enabled in 2.5.34.

Disabling devfs made it visible again.

Con.
