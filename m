Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbSLDIfs>; Wed, 4 Dec 2002 03:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266953AbSLDIfs>; Wed, 4 Dec 2002 03:35:48 -0500
Received: from denise.shiny.it ([194.20.232.1]:42948 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S266952AbSLDIfr>;
	Wed, 4 Dec 2002 03:35:47 -0500
Message-ID: <XFMail.20021204094315.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <1038953338.3ded2b7a5fe0d@kolivas.net>
Date: Wed, 04 Dec 2002 09:43:15 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Con Kolivas <conman@kolivas.net>
Subject: RE: [BENCHMARK] 2.5.40-mm1 with contest
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03-Dec-2002 Con Kolivas wrote:
>
> UP results
>
> process_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.20 [5]              108.1   58      84      40      1.62
> 2.5.50-mm1 [5]          86.6    78      18      20      1.30

Hm, load task gets half cpu time, but it goes 5 times slower
in 2.5.x. Why ? You can see a similar behaviour in other
tests too.


Bye.

