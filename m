Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263000AbSJGMLP>; Mon, 7 Oct 2002 08:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263002AbSJGMLP>; Mon, 7 Oct 2002 08:11:15 -0400
Received: from tomts26.bellnexxia.net ([209.226.175.189]:47859 "EHLO
	tomts26-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S263000AbSJGMLP>; Mon, 7 Oct 2002 08:11:15 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.40-mm2 with contest
Date: Mon, 7 Oct 2002 08:11:41 -0400
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>, Con Kolivas <conman@kolivas.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210070811.41861.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Actually at 50 it swaps a lot less.  This morning after the daily updatedb run, there
was nothing in swap.  There was alway stuff in swap after this in both 2.5 and 2.4.x...

Not sure if limiting swap is that good an idea.

Could we report on the peak swap usage and swap rates in the benchmark?  Note that
in most cases it the elasped time that is important, it would be a good idea to know 
how much we are swapping since this _might_ effect the bottom line.

Ed Tomlinson


