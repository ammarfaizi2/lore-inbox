Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUEOMHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUEOMHc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 08:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUEOMHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 08:07:32 -0400
Received: from bay18-f22.bay18.hotmail.com ([65.54.187.72]:58373 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262114AbUEOMEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 08:04:43 -0400
X-Originating-IP: [67.22.169.229]
X-Originating-Email: [jpiszcz@hotmail.com]
From: "Justin Piszcz" <jpiszcz@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.6 appears to be 3 to 4 times slower than 2.6.5.
Date: Sat, 15 May 2004 12:04:42 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY18-F22R9sJzcccki00011d12@hotmail.com>
X-OriginalArrivalTime: 15 May 2004 12:04:42.0252 (UTC) FILETIME=[CE275CC0:01C43A74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have memory benchmarks and compile benchmarks,

essentially

compiling takes ~5 sec on a 2.53ghz (533mhz bus/2GB ram box) for lilgp - 
genetic program
ram  =ddr 333
compiling takes ~15-20 sec on a 3ghz (not sure on bus/4gb ram box) for lilgp 
- genetic program
ram = ddr 400

dd if=/dev/zero of=/mnt/ramdisk/file bs=409e size=(64 or 256mb)
it is 12% faster on the slower (2.53ghz box) vs the box w/DDR 400mhz ram

Is anyone else having SERIOUS PROBLEMS with the 2.6.6 kernel as well?

_________________________________________________________________
Watch LIVE baseball games on your computer with MLB.TV, included with MSN 
Premium! http://join.msn.click-url.com/go/onm00200439ave/direct/01/

