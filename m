Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318795AbSHWMe0>; Fri, 23 Aug 2002 08:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318796AbSHWMe0>; Fri, 23 Aug 2002 08:34:26 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:36276 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S318795AbSHWMeZ>;
	Fri, 23 Aug 2002 08:34:25 -0400
Message-ID: <1030106313.3d662cc9589d5@kolivas.net>
Date: Fri, 23 Aug 2002 22:38:33 +1000
From: conman@kolivas.net
To: linux-kernel@vger.kernel.org
Subject: Combined performance patches update for 2.4.19
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've completed merging the following patches:

O(1) scheduler
Preemptible
Low latency

against 2.4.19

I've put the patch up here:
http://kernel.kolivas.net

This one definitely feels faster.
Feel free to give it a try and tell me what you think.

Con Kolivas
