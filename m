Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265017AbSJPOoP>; Wed, 16 Oct 2002 10:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265018AbSJPOoP>; Wed, 16 Oct 2002 10:44:15 -0400
Received: from ihemail2.lucent.com ([192.11.222.163]:24984 "EHLO
	ihemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S265017AbSJPOoN>; Wed, 16 Oct 2002 10:44:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15789.31874.550728.696896@gargle.gargle.HOWL>
Date: Wed, 16 Oct 2002 10:49:38 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Con Kolivas <conman@kolivas.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.43 with contest
In-Reply-To: <1034749489.3dad063203723@kolivas.net>
References: <1034749489.3dad063203723@kolivas.net>
X-Mailer: VM 7.07 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Con,

Why are you bothering to show the older 2.5.3x series of kernels, but
dropping the 2.4.18 results?  Wouldn't it make sense to see how the
latest kernels in each section were doing?

Con> Here are the latest contest (http://contest.kolivas.net) benchmarks including 2.5.43

Con> noload:
Con> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
Con> 2.5.38 [3]              72.0    93      0       0       1.07
Con> 2.5.39 [2]              72.2    93      0       0       1.07
Con> 2.5.40 [1]              72.5    93      0       0       1.08
Con> 2.5.41 [1]              73.8    93      0       0       1.10
Con> 2.5.42 [2]              72.5    93      0       0       1.08
Con> 2.5.42-mm3 [2]          78.1    93      0       0       1.16
Con> 2.5.43 [2]              74.6    92      0       0       1.11


Thanks,
John
